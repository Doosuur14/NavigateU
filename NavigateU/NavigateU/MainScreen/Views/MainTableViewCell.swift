//
//  MainTableViewCell.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 07.04.2024.
//

import UIKit

final class MainTableViewCell: UITableViewCell {

    private lazy var contentImage: UIImageView = UIImageView()
    private lazy var contentTitle: UILabel = UILabel()
    private lazy var contentSubtitle: UILabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpfunc()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with content: Content) {
        contentImage.image = content.photo
        contentTitle.text = content.title
        contentSubtitle.text = content.subTitle

    }

    private func setupContentImage() {
        addSubview(contentImage)
        contentImage.layer.cornerRadius = 10
        contentImage.layer.masksToBounds = true
        contentImage.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(300)
        }
    }

    private func setupContentTitle() {
        addSubview(contentTitle)
        contentTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        contentTitle.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(contentImage.snp.bottom).offset(3)
          //  make.width.equalTo(360)
            make.height.equalTo(25)
        }
    }

    private func setupContentSubtitle() {
        addSubview(contentSubtitle)
        contentSubtitle.font = UIFont.systemFont(ofSize: 15, weight: .light)
        contentSubtitle.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalTo(contentTitle.snp.bottom).offset(3)
          //  make.width.equalTo(360)
            make.height.equalTo(20)
        }
    }
    private func setUpfunc() {
        setupContentImage()
        setupContentTitle()
        setupContentSubtitle()
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
