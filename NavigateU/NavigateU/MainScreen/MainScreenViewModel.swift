//
//  MainScreenViewModel.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 07.04.2024.
//

import Foundation
import UIKit

class MainScreenViewModel {
    private var content: [Content] = []
    var filteredContent: [Content] = []
    var documentRemoteDataSource: DocumentRemoteDataSourceProtocol
    var reloadTableView: (() -> Void)?

    init(documentRemoteDataSource: DocumentRemoteDataSourceProtocol = DocumentRemoteDataSource.shared) {
        self.documentRemoteDataSource = documentRemoteDataSource
        setupMockData()
    }
    
    func numberOfRowsInSection() -> Int {
        return filteredContent.count
    }

    func heightForRowAt() -> Int {
        return 400
    }

    func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath)
        as? MainTableViewCell
        guard let cell = cell else {return UITableViewCell()}
        var contents: Content
        if filteredContent.isEmpty {
            contents = content[indexPath.row]
        } else {
            contents = filteredContent[indexPath.row]
        }
        cell.tag = indexPath.row
        cell.configureCell(with: contents)
        return cell
    }

    private func setupMockData() {
        documentRemoteDataSource.fetchContent { [weak self] result in
            switch result {
            case .success(let contentResponses):
                self?.content = contentResponses.map { response in
                    Content(id: response.id, photoName: response.imageUrl, title: response.title)
                }
                self?.filteredContent = self?.content ?? []
                DispatchQueue.main.async {
                    self?.reloadTableView?()
                }
            case .failure(let error):
                print("Error fetching content: \(error)")
            }
        }
    }

    func searchPost(_ searchText: String) {
        if searchText.isEmpty {
            filteredContent = content
        } else {
            filteredContent = content.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
        reloadTableView?()
    }

    func cancelButtonClicked() {
        filteredContent = content
        self.reloadTableView?()
    }
}
