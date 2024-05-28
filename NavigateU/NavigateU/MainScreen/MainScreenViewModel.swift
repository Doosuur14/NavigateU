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
        content = [Content(photo: UIImage(named: "documents1"),
                           title: "eVisa to Moscow.",subTitle: "A biometric passport valid for 6 months Read More......."),
                   Content(photo: UIImage(named: "headhunter"), title: "Online recruitment platform.",
                           subTitle: "Finding jobs in Russia has been made easy Read More......"),
                   Content(photo: UIImage(named: "redsquare"), title: "All about moscow redsquare.",
                           subTitle: "The most popular and famous square Read More......"),
                   Content(photo: UIImage(named: "english"), title: "The best job for native english speakers.", subTitle: "Knowing how to speak english in Russian Read More......"),
                   Content(photo: UIImage(named:"evisa" ), title: "Extension of Registration/Student Visa.", subTitle: "Please don't forget to submit documents Read More......"),
                   Content(photo: UIImage(named: "lake baikal"), title: "Lake Baikal.", subTitle: "The world's deepest and oldest lake Read More......"),
                   Content(photo: UIImage(named: "modelling"), title: "Part time jobs for students.",
                           subTitle: "Modelling is a very popular job foreign students work  Read More.......")
        ]
    }
}
