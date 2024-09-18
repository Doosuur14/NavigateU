//
//  Question.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 30.07.2024.
//

import Foundation

struct Question {
    let title: String
    let answer: String
}

struct QuestionResponse: Decodable {
    let title: String
    let answer: String
}
