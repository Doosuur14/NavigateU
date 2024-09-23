//
//  FAQViewModel.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 30.07.2024.
//

import Foundation
import UIKit

class FAQViewModel {
    private var content: [Question] = []
    var documentRemoteDataSource: DocumentRemoteDataSourceProtocol
    var reloadTableView: (() -> Void)?

    init(documentRemoteDataSource: DocumentRemoteDataSourceProtocol = DocumentRemoteDataSource.shared) {
        self.documentRemoteDataSource = documentRemoteDataSource
        setupMockData()
    }

    func heightForRowAt() -> Int {
        return 150
    }

    func numberOfRowsInSection() -> Int {
        content.count
    }
    func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FAQTableViewCell.FAQreuseIdentifier, for: indexPath)
                as? FAQTableViewCell else {
                return UITableViewCell()
        }
        let contents = content[indexPath.row]
        cell.configureCell(with: contents)
        return cell
    }

    private func setupMockData() {
        documentRemoteDataSource.fetchQuestions { [weak self] result in
            switch result {
            case .success(let questionResponses):
                self?.content = questionResponses.map { question in
                    Question(title: question.title, answer: question.answer)
                }
                DispatchQueue.main.async {
                    self?.reloadTableView?()
                }
            case .failure(let error):
                print("Error fetching content: \(error)")
            }
        }
    }
}
