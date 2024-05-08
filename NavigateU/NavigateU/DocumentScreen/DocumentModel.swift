//
//  DocumentModel.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 07.05.2024.
//

import Foundation
import UIKit
import Alamofire

 class DocumentModel {
     private var articles: [Article] = []

     init() {}

     func numberOfRowsInSection() -> Int {
         return articles.count
     }
     func heightForRowAt() -> Int {
         return 1000
     }

     func setupMockData(completion: @escaping (Error?) -> Void) {
         AF.request("http://localhost:8080/articles").responseDecodable(of: [Article].self) { response in
             switch response.result {
             case .success(let fetchedArticles):
                 self.articles = fetchedArticles
                 completion(nil)
                 //reload table view
             case .failure(let error):
                 print("There was error trying to fetch articles")
                 completion(error)
             }
         }

     }

     func configureCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: DocumentTableViewCell.reuseIdentifierForDoc, for: indexPath) as? DocumentTableViewCell
         guard let cell = cell else {return UITableViewCell()}
         cell.configureCell(with: articles[indexPath.row])
         return cell
     }

}
