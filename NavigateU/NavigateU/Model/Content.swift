//
//  Content.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 07.04.2024.
//

import Foundation
import UIKit

 struct Content {
     let id: Int
     let photoName: String
     let title: String

     var photo: UIImage? {
         return UIImage(named: photoName)
     }
}
struct ContentResponse: Decodable {
    let id: Int
    let imageUrl: String
    let title: String
}
