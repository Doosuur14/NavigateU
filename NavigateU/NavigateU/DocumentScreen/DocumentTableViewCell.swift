//
//  DocumentTableViewCell.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 07.05.2024.
//

import UIKit

class DocumentTableViewCell: UITableViewCell {
    lazy var title: UILabel = UILabel()
    lazy var image: UIImageView = UIImageView()
    lazy var content: UITextView = UITextView()
    lazy var likeButton: UIButton = UIButton()
    lazy var likeCount: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 func configureCell(with article: Article) {
        title.text = article.title
//        let imageData = try? Data(contentsOf: article.imageURL)
//        if let imageData = imageData {
//            DispatchQueue.main.async { [weak self] in
//                self?.image.image = UIImage(data: imageData)
//            }
//        }

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
                 self.image.image = UIImage(data: data)
             }
         }.resume()
        content.text = article.content
        likeCount.text = article.likes
    }
    private func setupTitle() {
        addSubview(title)
        title.font = .systemFont(ofSize: 15, weight: .bold)
        title.textColor = .black
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    private func setupImage() {
        addSubview(image)
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        image.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(title.snp.bottom).offset(10)
            make.height.equalTo(150)
        }
    }

    private func setupContent() {
        addSubview(content)
        content.font = .systemFont(ofSize: 15, weight: .light)
        content.isScrollEnabled = true
        content.textColor = UIColor(named: "SubtitleColor")
        content.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(500)
        }
    }

    private func setupLikeButton() {
        addSubview(likeButton)
        likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        likeButton.tintColor = UIColor(named: "CustomColor")
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(content.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(40)

        }
    }

    private func setupLikeCount() {
        addSubview(likeCount)
        likeCount.textColor = .black
        likeCount.font = .systemFont(ofSize: 17, weight: .medium)
        likeCount.snp.makeConstraints { make in
            make.top.equalTo(content.snp.bottom).offset(10)
            make.leading.equalTo(likeButton.snp.trailing).offset(3)
        }
    }
    private func setupViews() {
        setupTitle()
        setupImage()
        setupContent()
        setupLikeButton()
        setupLikeCount()
    }
}

extension UITableViewCell {
    static var reuseIdentifierForDoc: String {
        return String(describing: self)
    }
}
