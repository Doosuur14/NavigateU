//
//  DocumentViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 26.05.2024.
//

import UIKit

class DocumentViewController: UIViewController {
    private let article: Article
    var document: DocumentView?

    init(article: Article) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }
    
    private func setupViews() {
        document = DocumentView(frame: view.bounds)
        view = document
        view.backgroundColor = .white
        document?.title.text = article.title
        URLSession.shared.dataTask(with: article.imageURL) { [weak self] (data, response, error) in
                           guard let self = self else { return }

                           if let error = error {
                               print("Error loading image: \(error)")
                               return
                           }
                           guard let data = data else {
                               print("No image data available")
                               return
                           }
                           DispatchQueue.main.async {
                               self.document?.image.image = UIImage(data: data) ?? UIImage(systemName: "person")
                           }
                       }.resume()
        document?.content.text = article.content
        document?.likeCount.text = article.likes
    }
}
