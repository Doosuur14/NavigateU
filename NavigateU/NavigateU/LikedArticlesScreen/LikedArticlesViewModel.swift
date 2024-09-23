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

    func fetchLikedArticles() {
        let fetchedArticles = documentLocalDataSource.getLikedArticles()
        self.likedArticles = fetchedArticles
        print("Fetched Liked Articles: \(fetchedArticles.count)")
    }

    func sortArticlesByLikes() {
        likedArticles.sort { (article1, article2) -> Bool in
            guard let likes1 = Int(article1.likes ?? "0"), let likes2 = Int(article2.likes ?? "0") else {
                return false
            }
            return likes1 > likes2
        }
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
