//
//  DocumentRemoteDataSource.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 24.05.2024.
//

import Foundation
import Alamofire
import CoreData

protocol DocumentRemoteDataSourceProtocol {
    func fetchArticles(completion: @escaping (Result<[ArticleResponse], Error>) -> Void)
    func fetchArticleDetails(articleId: Int, completion: @escaping (Result<ArticleResponse, Error>) -> Void)
    func saveArticlesToCoreData(articleResponses: [ArticleResponse], completion: @escaping (Result<[Article], Error>) -> Void) async
    func saveArticleDetailToCoreData(articleResponse: ArticleResponse, completion: @escaping (Result<Article, Error>) -> Void) async
    func fetchContent(completion: @escaping (Result<[ContentResponse], Error>) -> Void)
    func fetchQuestions(completion: @escaping (Result<[QuestionResponse], any Error>) -> Void)
}

class DocumentRemoteDataSource: DocumentRemoteDataSourceProtocol {
    static let shared = DocumentRemoteDataSource()

    private var articles: [ArticleResponse] = []

    func fetchArticles(completion: @escaping (Result<[ArticleResponse], any Error>) -> Void) {
        AF.request("http://172.20.10.3:8080/articles").responseDecodable(of: [ArticleResponse].self) { response in
            switch response.result {
            case .success(let articles):
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchArticleDetails(articleId: Int, completion: @escaping (Result<ArticleResponse, any Error>) -> Void) {
     //   let urlString = "http://localhost:8080/articles/\(articleId)"
        let urlString = "http://172.20.10.3:8080/articles/\(articleId)"
        AF.request(urlString).responseDecodable(of: ArticleResponse.self) { response in
            switch response.result {
            case .success(let article):
                completion(.success(article))
            case .failure(let error):
                print("Error fetching article details: \(error)")
                completion(.failure(error))
            }
        }
    }

    func saveArticlesToCoreData(articleResponses: [ArticleResponse],
                                completion: @escaping (Result<[Article], Error>) -> Void) async {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        await context.perform {
            do {
                var articles = [Article]()
                for articleResponse in articleResponses {
                    let article = Article(context: context)
                    article.id = Int32(articleResponse.id)
                    article.title = articleResponse.title
                    article.imageURL = articleResponse.imageURL
                    article.content = articleResponse.content
                    article.likes = articleResponse.likes
                    articles.append(article)
                }
                try context.save()
                completion(.success(articles))
            } catch {
                context.rollback()
                completion(.failure(error))
            }
        }
    }

    func saveArticleDetailToCoreData(articleResponse: ArticleResponse,
                                     completion: @escaping (Result<Article, Error>) -> Void) async {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        await context.perform {
            do {
                let article = Article(context: context)
                article.id = Int32(articleResponse.id)
                article.title = articleResponse.title
                article.imageURL = articleResponse.imageURL
                article.content = articleResponse.content
                article.likes = articleResponse.likes
                try context.save()
                completion(.success(article))
            } catch {
                context.rollback()
                completion(.failure(error))
            }
        }
    }

    func fetchContent(completion: @escaping (Result<[ContentResponse], any Error>) -> Void) {
        AF.request("http://172.20.10.3:8080/contents").responseDecodable(of: [ContentResponse].self) { response in
            switch response.result {
            case .success(let content):
                completion(.success(content))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchQuestions(completion: @escaping (Result<[QuestionResponse], any Error>) -> Void) {
        AF.request("http://172.20.10.3:8080/questions").responseDecodable(of: [QuestionResponse].self) { response in
            switch response.result {
            case .success(let question):
                completion(.success(question))
            case .failure(let error):
                print("Error fetching questions: \(error)")
                completion(.failure(error))
            }
        }
    }
}
