//
//  DocumentLocalDataSource.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 28.05.2024.
//

import Foundation
import FirebaseAuth
import CoreData
import Combine

protocol DocumentLocalDataSourceProtocol {
    func likeArticle(article: Article, completion: @escaping (Result<Void, Error>) -> Void)
    func unlikeArticle(article: Article, completion: @escaping (Result<Void, Error>) -> Void)
    func getLikedArticles() -> [Article]
    func isArticleLiked(articleId: Int) -> Bool
    func getArticle(articleId: Int) -> Article?
    func removeDuplicateArticles()

    var articleLiked: Bool { get set }
    var articleUnliked: Bool { get set }
    var articleLikedPublisher: Published<Bool>.Publisher { get }
    var articleUnlikedPublisher: Published<Bool>.Publisher { get }
}

class DocumentLocalDataSource: DocumentLocalDataSourceProtocol {
    static let shared = DocumentLocalDataSource()
    @Published var articleLiked: Bool = false
    @Published var articleUnliked: Bool = false


    var articleLikedPublisher: Published<Bool>.Publisher { $articleLiked }
    var articleUnlikedPublisher: Published<Bool>.Publisher { $articleUnliked }

    private var context: NSManagedObjectContext {
        return CoreDataManager.shared.persistentContainer.viewContext
    }

    func getLikedArticles() -> [Article] {
        guard let currentUser = Auth.auth().currentUser?.uid else {
            print("no user found")
            return []
        }
        let managedObjectContext = context
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %@", currentUser)
        var articles: [Article] = []
        context.performAndWait {

            do {
                let users = try managedObjectContext.fetch(fetchRequest)
                if let user = users.first, let likedArticles = user.likedArticles as? Set<Article> {
                    articles = Array(likedArticles)
                }
            } catch {
                print("Error fetching liked articles: \(error)")
            }

        }
        return articles
    }

    func isArticleLiked(articleId: Int) -> Bool {
        guard let currentUser = Auth.auth().currentUser?.uid else {
            print("no user found")
            return false
        }

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %@", currentUser)

        do {
            let users = try context.fetch(fetchRequest)
            if let user = users.first, let likedArticles = user.likedArticles as? Set<Article> {
                let isLiked = likedArticles.contains { $0.id == articleId }
                return isLiked
            }
        } catch {
            print("Error fetching liked articles: \(error)")
        }
        return false
    }

    func getArticle(articleId: Int) -> Article? {
        let fetchRequest: NSFetchRequest<Article> = Article.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %d", articleId)

        do {
            let articles = try context.fetch(fetchRequest)
            return articles.first
        } catch {
            print("Error found while fetching articles")
        }
        return nil
    }

    func likeArticle(article: Article, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.uid else {
            print("no user found")
            return
        }

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %@", currentUser)

        context.perform {
            do {
                let users = try self.context.fetch(fetchRequest)
                if let user = users.first {
                    let likedArticles = user.likedArticles as? Set<Article> ?? Set<Article>()
                    let likedArticleIds = likedArticles.map { $0.id }
                    if !likedArticles.contains(where: { $0.id == article.id }) {
                        user.addToLikedArticles(article)
                        article.addToLikedByUser(user)
                        if let likes = article.likes, let likesInt = Int(likes) {
                            article.likes = String(likesInt + 1)
                        }
                        try self.context.save()
                        self.articleLiked = true
                        completion(.success(()))
                    } else {
                        print("Article already liked.")
                        self.articleUnliked = false
                        completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Article already liked"])))
                    }
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User not found"])))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }

    func unlikeArticle(article: Article, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let currentUser = Auth.auth().currentUser?.uid else {
            print("no user found")
            return
        }

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "uid == %@", currentUser)

        context.perform {
            do {
                let users = try self.context.fetch(fetchRequest)
                if let user = users.first, let likedArticles = user.likedArticles as? Set<Article>, likedArticles.contains(where: { $0.id == article.id }) {

                    user.removeFromLikedArticles(article)
                    article.removeFromLikedByUser(user)
                    if let likes = article.likes, let likesInt = Int(likes) {
                        article.likes = String(likesInt - 1)
                    }
                    try self.context.save()
                    self.articleUnliked = true
                    completion(.success(()))
                } else {
                    self.articleUnliked = false
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Article not found in liked articles"])))
                }
            } catch {
                completion(.failure(error))
            }
        }
    }
    func removeDuplicateArticles() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        context.perform {
            do {
                let users = try self.context.fetch(fetchRequest)
                if let user = users.first {
                    if let likedArticles = user.likedArticles as? Set<Article> {
                        let articleIDs = likedArticles.map { $0.id }
                        let uniqueArticleIDs = Set(articleIDs)

                        for articleID in uniqueArticleIDs {
                            let duplicates = likedArticles.filter { $0.id == articleID }
                            if duplicates.count > 1 {
                                for duplicate in duplicates.dropFirst() {
                                    user.removeFromLikedArticles(duplicate)
                                    self.context.delete(duplicate)
                                }
                            }
                        }
                        try self.context.save()
                        print("Removed duplicates from liked articles.")
                    }
                }
            } catch {
                print("Failed to remove duplicates: \(error)")
            }
        }
    }
}
