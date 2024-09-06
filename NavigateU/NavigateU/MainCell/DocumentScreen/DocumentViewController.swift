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

    private var isLiked: Bool {
        get {
            return UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLikedKey(for: article.id))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.isLikedKey(for: article.id))
        }
    }

    private var likeCountValue: Int {

        get {
            return UserDefaults.standard.integer(forKey: UserDefaultsKeys.likeCountKey(for: article.id))
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaultsKeys.likeCountKey(for: article.id))
        }
    }


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
        document?.delegate = self
        if UserDefaults.standard.object(forKey: UserDefaultsKeys.likeCountKey(for: article.id)) == nil {
            likeCountValue =  Int(article.likes) ?? 0
            document?.likeCount.text = article.likes
        } else {
            document?.likeCount.text = "\(likeCountValue)"
        }
        updateLikeButton()
    }
}

extension DocumentViewController: LikeButtonDelegate {
    func didtapLikeButton() {
        if !isLiked {
            isLiked = true
            likeCountValue += 1
        } else {
            isLiked = false
            likeCountValue -= 1
        }
        updateLikeButton()
        UserDefaults.standard.set(isLiked, forKey: UserDefaultsKeys.isLikedKey(for: article.id))
        UserDefaults.standard.set(likeCountValue, forKey: UserDefaultsKeys.likeCountKey(for: article.id))
    }

    private func updateLikeButton() {
        let imageName = isLiked ? "heart.fill" : "heart"
        let color = isLiked ? UIColor.red : UIColor(named: "CustomColor")
        document?.likeButton.setImage(UIImage(systemName: imageName), for: .normal)
        document?.likeButton.tintColor = color
        document?.likeCount.text = "\(likeCountValue)"
    }
}
