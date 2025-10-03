//
//  DocumentViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 26.05.2024.
//

import UIKit

class DocumentViewController: UIViewController {
    private var article: Article
    private let documentLocalDataSource: any DocumentLocalDataSourceProtocol
    var document: DocumentView?


    private var isLiked: Bool = false

    init(article: Article, dataSource: any DocumentLocalDataSourceProtocol = DocumentLocalDataSource.shared) {
        self.article = article
        self.documentLocalDataSource = dataSource
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadArticleData()
    }

    private func loadArticleData() {
         if let updatedArticle = documentLocalDataSource.getArticle(articleId: Int(article.id)) {
           self.article = updatedArticle
        }
        self.isLiked = documentLocalDataSource.isArticleLiked(articleId: Int(article.id))
        updateLikeButton()
    }

    private func setupViews() {
        document = DocumentView(frame: view.bounds)
        view = document
        view.backgroundColor = .systemBackground
        document?.title.text = article.title
        if let imageUrlString = article.imageURL, let url = URL(string: imageUrlString) {
            ImageService.shared.loadImage(from: url) { [weak self] result in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    switch result {
                    case .success(let data):
                        self.document?.image.image = data
                    case .failure(let error):
                        print("Error loading image: \(error)")
                        self.document?.image.image = UIImage(systemName: "person")
                    }
                }
            }
        }
        document?.content.text = article.content
        document?.delegate = self
        document?.likeCount.text = article.likes
        updateLikeButton()
    }
}

extension DocumentViewController: LikeButtonDelegate {
    private func updateLikeButton() {
            if  self.isLiked {
                document?.likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
                document?.likeButton.tintColor = UIColor.red
            } else {
                document?.likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
                document?.likeButton.tintColor = UIColor(named: "CustomColor")
            }
            document?.likeCount.text = article.likes
    }
    
    func didtapLikeButton() {
        if isLiked {
            documentLocalDataSource.unlikeArticle(article: article) { [weak self] result in
                switch result {
                case .success:
                    self?.isLiked = false
                    self?.updateLikeButton()
                case .failure:
                    AlertManager.shared.showNoNetworkError(viewCon: self ?? UIViewController())
                }
            }
        } else {
            documentLocalDataSource.likeArticle(article: article) { [weak self] result in
                switch result {
                case .success:
                    self?.isLiked = true
                    self?.updateLikeButton()
                case .failure:
                    AlertManager.shared.showNoNetworkError(viewCon: self ?? UIViewController())
                }
            }
        }
    }
}
