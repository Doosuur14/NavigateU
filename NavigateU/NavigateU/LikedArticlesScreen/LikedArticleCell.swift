//
//  LikedArticleCell.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.07.2024.
//

import UIKit

final class LikedArticleCell: UITableViewCell {

    private lazy var contentImage: UIImageView = UIImageView()
    private lazy var contentTitle: UILabel = UILabel()
    private lazy var contentDescription: UITextView = UITextView()

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
                    print("Error loading image: \(error)")
                    return
                }
                guard let data = data else {
                    print("No image data available")
                    return
                }
                DispatchQueue.main.async {
                    self.contentImage.image = UIImage(data: data) ?? UIImage(systemName: "person")
                }
            }.resume()
        }
        contentTitle.text = article.title
        contentDescription.text = article.content

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
        contentDescription.textColor = .black
        contentDescription.backgroundColor = .clear
        contentDescription.isEditable = false
        contentDescription.isScrollEnabled = false
        contentDescription.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(contentTitle.snp.bottom).offset(3)
            make.trailing.equalTo(-16)
            make.bottom.equalToSuperview().inset(16)
        }
    }
    private func setUpfunc() {
        setupContentImage()
        setupContentTitle()
        setupContentDescription()
    }
}

extension UITableViewCell {
    static var LikedArticleReuseIdentifier: String {
        return String(describing: self)
    }
}
