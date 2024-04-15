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

    init() {
        setupMockData()
    }

    func numberOfRowsInSection() -> Int {
        return content.count
    }
    func heightForRowAt() -> Int {
        return 400
    }

    func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.reuseIdentifier, for: indexPath) as? MainTableViewCell
        guard let cell = cell else {return UITableViewCell()}
        cell.configureCell(with: content[indexPath.row])
        return cell
    }
    private func setupMockData() {
        content = [Content(photo: UIImage(named: "documents1"), title: "Documents", subTitle: "The easiet way to process your documents."),
                   Content(photo: UIImage(named: "speaking"), title: "Speaking Clubs", subTitle: "Master russian language the fastest way possible."),
                   Content(photo: UIImage(named: "tour"), title: "Places To Visit", subTitle: "Amazing places you have to visit in Russia."),
                   Content(photo: UIImage(named: "jobs"), title: "Where To Find Jobs", subTitle: "The best jobs for your schedule as a student")
        ]
    }
}
