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

    init() {
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
        content = [ Question(title: "How can I like an article?",
                             answer: "To like an article, simply tap the heart icon at the bottom of the article. You can view all your liked articles in the 'Favorites' section."),
                    Question(title: "How do I edit my profile?",
                             answer: "To edit your profile, go to the 'Profile' tab and tap the 'Edit Profile' button. From there, you can update your personal information and profile picture."),
                    Question(title: "How do I switch to dark theme?",
                             answer: "You can switch to dark theme by going to the app settings and toggling the 'Dark Theme' option. The app will instantly switch to a darker color scheme."),
                    Question(title: "How can I create an article?",
                             answer: "To create an article, go to the 'Create' tab and fill in the title and content fields. Once you're ready, tap 'Submit' to publish your article."),
                    Question(title: "How can I rate an article?",
                             answer: "To rate an article, scroll to the bottom of the article and select the number of stars you wish to give. You can also leave a comment along with your rating."),
                    Question(title: "What should I do if I encounter issues?",
                             answer: "If you encounter any issues or have questions, please contact our support team through the 'Help & Support' section in the app settings.")
        ]
    }
}