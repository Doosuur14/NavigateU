//
//  Article.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 07.05.2024.
//

import Foundation
import CoreData

struct ArticleResponse: Decodable {
    let id: Int
    let title: String
    let content: String
    let imageURL: String
    let likes: String
}

extension Article {
    convenience init(articleResponse: ArticleResponse, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = Int32(articleResponse.id)
        self.title = articleResponse.title
        self.imageURL = articleResponse.imageURL
        self.content = articleResponse.content
        self.likes = articleResponse.likes
    }
}

