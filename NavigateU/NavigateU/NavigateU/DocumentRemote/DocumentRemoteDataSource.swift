//
//  DocumentRemoteDataSource.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 24.05.2024.
//

import Foundation
import Alamofire

protocol DocumentRemoteDataSourceProtocol {
    func fetchArticles(completion: @escaping (Result<[Article], Error>) -> Void)
    func fetchArticleDetails(articleId: Int, completion: @escaping (Result<Article, Error>) -> Void)
}

class DocumentRemoteDataSource: DocumentRemoteDataSourceProtocol {

    private var articles: [Article] = []

    func fetchArticles(completion: @escaping (Result<[Article], any Error>) -> Void) {
        AF.request("http://localhost:8080/articles").responseDecodable(of: [Article].self) { response in
            switch response.result {
            case .success(let articles):
                completion(.success(articles))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func fetchArticleDetails(articleId: Int, completion: @escaping (Result<Article, any Error>) -> Void) {
        let urlString = "http://localhost:8080/articles/\(articleId)"
        AF.request(urlString).responseDecodable(of: Article.self) { response in
            switch response.result {
            case .success(let article):
                completion(.success(article))
            case .failure(let error):
                print("Error fetching article details: \(error)")
                completion(.failure(error))
            }
        }
    }
}

