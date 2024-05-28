//
//  UserDefaults.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 28.05.2024.
//

import Foundation

struct UserDefaultsKeys {
    static func isLikedKey(for articleId: Int) -> String {
        return "isLikedKey_\(articleId)"
    }

    static func likeCountKey(for articleId: Int) -> String {
        return "likeCountKey_\(articleId)"
    }
}
