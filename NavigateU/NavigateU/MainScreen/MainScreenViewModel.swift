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
    private var filteredContent: [Content] = []
    var reloadTableView: (() -> Void)?

    init() {
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
        content = [Content(photo: UIImage(named: "documents1"),
                           title: "eVisa to Moscow.",subTitle: "A biometric passport valid for 6 months Read More......."),
                   Content(photo: UIImage(named: "headhunter"), title: "Online recruitment platform.",
                           subTitle:"Finding jobs in Russia has been made easy Read More......"),
                   Content(photo: UIImage(named: "redsquare"),
                           title: "All about moscow redsquare.",
                           subTitle:"The most popular and famous square Read More......"),
                   Content(photo: UIImage(named:"speakingclub1"),
                           title: "The best job for native english speakers.",
                           subTitle:"Knowing how to speak english in Russian Read More......"),
                   Content(photo: UIImage(named:"evisa"),
                           title: "Extension of Registration/Student Visa.",
                           subTitle: "Please don't forget to submit documents Read More......"),
                   Content(photo: UIImage(named: "lake baikal"),
                           title: "Lake Baikal.",
                           subTitle:"The world's deepest and oldest lake Read More......"),
                   Content(photo: UIImage(named: "modelling"),
                           title: "Part time jobs for students.",
                           subTitle:"Modelling is a very popular job foreign Read More.......")
        ]
        filteredContent = content
    }

    func searchPost(_ searchText: String) {
        if searchText.isEmpty {
            filteredContent = content
        } else {
            filteredContent = content.filter {
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.subTitle.lowercased().contains(searchText.lowercased())
            }
        }
        reloadTableView?()
    }

    func cancelButtonClicked() {
        filteredContent = content
        self.reloadTableView?()
    }
}
