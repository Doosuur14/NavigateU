//
//  ProfileTableViewCell.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 12.04.2024.
//

import UIKit

class ProfileTableViewCell: UITableViewCell {
    lazy var iconImage: UIImageView = UIImageView()
    lazy var contentLabel: UILabel = UILabel()
    lazy var redirectButton: UIButton = UIButton()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupIconImage()
        setupContentlabel()
        setupButton()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureCell(with profile: Profile) {
        iconImage.image = profile.photo
        contentLabel.text = profile.label
    }

    private func setupIconImage() {
        addSubview(iconImage)
        iconImage.tintColor = UIColor(named: "CustomColor")
        iconImage.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.top.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }

    }
    private func setupContentlabel() {
        addSubview(contentLabel)
        contentLabel.textColor = .black
        contentLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        contentLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImage.snp.trailing).offset(16)
            make.height.equalTo(25)
            make.centerY.equalToSuperview()
        }
    }
    private func setupButton() {
        addSubview(redirectButton)
        redirectButton.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        redirectButton.tintColor = UIColor(named: "CustomColor")
        redirectButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}

extension UITableViewCell {
    static var profileReuseIdentifier: String {
        return String(describing: self)
    }
}
