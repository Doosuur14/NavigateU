//
//  Article.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 07.05.2024.
//

import Foundation

struct Article: Decodable {
    let id: Int
    let title: String
    let content: String
    let imageURL: URL
    let likes: String
}
