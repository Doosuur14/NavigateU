//
//  LikedArticleCell.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.07.2024.
//

import UIKit

 class LikedArticleCell: UITableViewCell {
    
    private lazy var contentImage: UIImageView = UIImageView()
    private lazy var contentTitle: UILabel = UILabel()
    private lazy var contentDescription: UITextView = UITextView()
    lazy var likeButton: UIButton = UIButton()
    lazy var likeCount: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpfunc()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(with article: Article) {
        if let url = URL(string: article.imageURL ?? "") {
            URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let self = self else { return }
                if let error = error {
                    return
                }
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.contentImage.image = UIImage(data: data) ?? UIImage(systemName: "person")
                }
            }.resume()
        }
        contentTitle.text = article.title
        contentDescription.text = article.content
        likeCount.text = article.likes

    }
    
    private func setupContentImage() {
        addSubview(contentImage)
        contentImage.layer.cornerRadius = 10
        contentImage.layer.masksToBounds = true
        contentImage.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview()
            make.height.equalTo(300)
        }
    }
    
    private func setupContentTitle() {
        addSubview(contentTitle)
        contentTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        contentTitle.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(contentImage.snp.bottom).offset(3)
            make.height.equalTo(25)
        }
    }
    
    private func setupContentDescription() {
        addSubview(contentDescription)
        contentDescription.font = UIFont.systemFont(ofSize: 15, weight: .light)
        contentDescription.textColor = .label
        contentDescription.backgroundColor = .clear
        contentDescription.isEditable = false
        contentDescription.isScrollEnabled = false
        contentDescription.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(contentTitle.snp.bottom).offset(3)
            make.trailing.equalTo(-16)
        }
    }

    private func setupLikeButton() {
        addSubview(likeButton)
        likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        likeButton.tintColor = UIColor(named: "CustomColor")
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(contentDescription.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(40)
        }
    }

    private func setupLikeCount() {
        addSubview(likeCount)
        likeCount.textColor = .label
        likeCount.font = .systemFont(ofSize: 17, weight: .medium)
        likeCount.snp.makeConstraints { make in
            make.top.equalTo(contentDescription.snp.bottom).offset(10)
            make.leading.equalTo(likeButton.snp.trailing).offset(3)
        }
    }

    private func setUpfunc() {
        setupContentImage()
        setupContentTitle()
        setupContentDescription()
        setupLikeButton()
        setupLikeCount()
    }
}

extension UITableViewCell {
    static var LikedArticleReuseIdentifier: String {
        return String(describing: self)
    }
}
