//
//  ProfileView.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 12.04.2024.
//

import UIKit

final class ProfileView: UIView {

    lazy var avatarImage: UIImageView = UIImageView()
    lazy var fullName: UILabel = UILabel()
    lazy var userEmail: UILabel = UILabel()
    lazy var tableView: UITableView = UITableView()
    let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()

    }
    private func setupViews() {
        setupAvatarImage()
        setupFullname()
        setupUseremail()
        setupStackview()
        setUpTableview()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupAvatarImage() {
        addSubview(avatarImage)
        avatarImage.image = UIImage(named: "dp2")
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = 50
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(16)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
    }
    private func setupFullname() {
        addSubview(fullName)
        fullName.text = "Faki Doosuur"
        fullName.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        fullName.textColor = .black
    }
    private func setupUseremail() {
        addSubview(userEmail)
        userEmail.text = "doosuur14@gmail.com"
        userEmail.textColor = .black
        userEmail.font = UIFont.systemFont(ofSize: 12, weight: .light)
    }
    private func setupStackview() {
        addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 0.5
        stackView.addArrangedSubview(fullName)
        stackView.addArrangedSubview(userEmail)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(avatarImage.snp.trailing).offset(5)
            make.height.equalTo(50)
            make.width.equalTo(150)
        }
    }

    private func setUpTableview() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
