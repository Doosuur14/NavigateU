//
//  LikedArticlesViewModel.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.07.2024.
//

import Foundation
import UIKit
import Combine

final class LikedArticlesViewModel {

    var likedArticles: [Article] = []
    var documentLocalDataSource: DocumentLocalDataSourceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(documentLocalDataSource: DocumentLocalDataSourceProtocol = DocumentLocalDataSource.shared) {
        self.documentLocalDataSource = documentLocalDataSource
        setupBindings()
        fetchLikedArticles()
    }

    func heightForRowAt() -> Int {
        return 700
    }

    func numberOfRowsInSection() -> Int {
        likedArticles.count
    }

    func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LikedArticleCell.LikedArticleReuseIdentifier, for: indexPath) as? LikedArticleCell else {
                return UITableViewCell()
        }
        let article = likedArticles[indexPath.row]
        cell.configureCell(with: article)
        return cell
    }

    func resolveFaults(for articles: [Article]) -> [Article] {
        return articles.map { article in
            _ = article.title
            _ = article.imageURL
            _ = article.content
            return article
        }
    }

    func fetchLikedArticles() {
        var fetchedArticles = documentLocalDataSource.getLikedArticles()
        fetchedArticles = resolveFaults(for: fetchedArticles)
        self.likedArticles = fetchedArticles
        print("Fetched liked articles for view model side: \(likedArticles)")
    }
    private func setupBindings() {
            documentLocalDataSource.articleLikedPublisher
                .sink { [weak self] _ in
                    self?.fetchLikedArticles()
                }
                .store(in: &cancellables)

            documentLocalDataSource.articleUnlikedPublisher
                .sink { [weak self] _ in
                    self?.fetchLikedArticles()
                }
                .store(in: &cancellables)
        }
}
