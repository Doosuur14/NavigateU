//
//  DocumentView.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 07.05.2024.
//

import UIKit

class DocumentView: UIView {

    lazy var title: UILabel = UILabel()
    lazy var image: UIImageView = UIImageView()
    lazy var content: UITextView = UITextView()
    lazy var likeButton: UIButton = UIButton()
    lazy var likeCount: UILabel = UILabel()


    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }



    private func setupTitle() {
        addSubview(title)
        title.font = .systemFont(ofSize: 15, weight: .bold)
        title.textColor = .black
        title.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(16)
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
            make.top.equalTo(title.snp.bottom).offset(20)
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
            make.height.equalTo(350)
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
