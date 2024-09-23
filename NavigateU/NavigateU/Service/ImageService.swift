//
//  ImageService.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 04.09.2024.
//

import Foundation
import UIKit

final class ImageService {
    
    static let shared = ImageService()

//    func loadImage(from url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            guard let data = data else {
//                let noDataError = NSError(domain: "ImageServiceErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "No image data available"])
//                completion(.failure(noDataError))
//                return
//            }
//            completion(.success(data))
//        }.resume()
//    }
    let imageCache = NSCache<NSString, UIImage>()

    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            completion(.success(cachedImage))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                let noDataError = NSError(domain: "ImageServiceErrorDomain", code: -1, userInfo: [NSLocalizedDescriptionKey: "No image data available"])
                completion(.failure(noDataError))
                return
            }

            self.imageCache.setObject(image, forKey: url.absoluteString as NSString)
            completion(.success(image))
        }.resume()
    }

  }

