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


    private enum CodingKeys: String, CodingKey {
            case id, title, content, imageURL, likes
        }
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(Int.self, forKey: .id)
            title = try container.decode(String.self, forKey: .title)
            content = try container.decode(String.self, forKey: .content)
            // Decode imageURL as URL
            let urlString = try container.decode(String.self, forKey: .imageURL)
            guard let url = URL(string: urlString) else {
                throw DecodingError.dataCorruptedError(forKey: .imageURL, in: container, debugDescription: "Invalid URL string.")
            }
            imageURL = url
            likes = try container.decode(String.self, forKey: .likes)
        }
}
