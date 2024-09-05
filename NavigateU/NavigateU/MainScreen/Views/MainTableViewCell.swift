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


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpfunc()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func configureCell(with content: Content) {
        guard let url = URL(string: content.photoName) else { return }
        let cellTag = self.tag
        ImageService.shared.loadImage(from: url) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        if self?.tag == cellTag {
                            self?.contentImage.image = image
                        }
                    }
                }
            case .failure(let error):
                print("Error loading image: \(error)")
            }
        }
        contentTitle.text = content.title
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

    private func setUpfunc() {
        setupContentImage()
        setupContentTitle()
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
