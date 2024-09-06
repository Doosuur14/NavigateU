//
//  ProfileView.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 12.04.2024.
//

import UIKit

protocol ProfileViewDelegate: AnyObject {
    func didPressLogoutButton()
    func didPressDeleteButton()
}

final class ProfileView: UIView {

    lazy var avatarImage: UIImageView = UIImageView()
    lazy var firstName: UILabel = UILabel()
    lazy var lastName: UILabel = UILabel()
    lazy var userEmail: UILabel = UILabel()
    lazy var tableView: UITableView = UITableView()
    lazy var logOut: UIButton = UIButton()
    lazy var deleteAccount: UIButton = UIButton()
    let stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()

    }
    private func setupViews() {
        setupAvatarImage()
        setupFirstname()
        setupLastname()
        setupUseremail()
        setupStackView()
        setupTableview()
        setupLogout()
        setupDelete()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    weak var delegate: ProfileViewDelegate?

    private func setupAvatarImage() {
        addSubview(avatarImage)
        avatarImage.clipsToBounds = true
        avatarImage.layer.borderColor = UIColor(named: "CustomColor")?.cgColor
        avatarImage.layer.borderWidth = 1.0
        avatarImage.layer.cornerRadius = 50
        avatarImage.isUserInteractionEnabled = true
        avatarImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.leading.equalTo(16)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
    }

    private func setupFirstname() {
        addSubview(firstName)
        firstName.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        firstName.textColor = .black
    }
    private func setupLastname() {
        addSubview(lastName)
        lastName.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        lastName.textColor = .black
    }

    private func setupUseremail() {
        addSubview(userEmail)
        userEmail.textColor = .black
        userEmail.font = UIFont.systemFont(ofSize: 12, weight: .light)
    }
    private func setupStackView() {

        addSubview(stackView)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 5

        let nameStackView = UIStackView()
            nameStackView.axis = .horizontal
            nameStackView.alignment = .leading
            nameStackView.spacing = 5
            nameStackView.addArrangedSubview(firstName)
            nameStackView.addArrangedSubview(lastName)

        stackView.addArrangedSubview(nameStackView)
        stackView.addArrangedSubview(userEmail)

        stackView.snp.makeConstraints { make in
            make.centerY.equalTo(avatarImage.snp.centerY)
            make.leading.equalTo(avatarImage.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    private func setupTableview() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(avatarImage.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-60)
        }
    }

    private func setupLogout() {
        addSubview(logOut)
        logOut.setTitle("Logout", for: .normal)
        logOut.backgroundColor = UIColor(named: "CustomColor")
        logOut.setTitleColor(.white, for: .normal)
        logOut.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        let action = UIAction { [weak self] _ in
            print("Logout button pressed")
            self?.delegate?.didPressLogoutButton()
        }
        logOut.addAction(action, for: .touchUpInside)
        logOut.clipsToBounds = true
        logOut.layer.cornerRadius = 10
        logOut.snp.makeConstraints { make in
            make.leading.equalTo(16)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(tableView.snp.bottom).offset(-10)
        }
    }

    private func setupDelete() {
        addSubview(deleteAccount)
        deleteAccount.setTitle("Delete", for: .normal)
        deleteAccount.backgroundColor = UIColor(named: "CustomColor")
        deleteAccount.setTitleColor(.white, for: .normal)
        deleteAccount.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        let action = UIAction { [weak self] _ in
            print("Delete button pressed")
            self?.delegate?.didPressDeleteButton()
        }
        deleteAccount.addAction(action, for: .touchUpInside)
        deleteAccount.clipsToBounds = true
        deleteAccount.layer.cornerRadius = 10
        deleteAccount.snp.makeConstraints { make in
            make.leading.equalTo(logOut.snp.trailing).offset(16)
            make.width.equalTo(200)
            make.height.equalTo(50)
            make.top.equalTo(tableView.snp.bottom).offset(-10)
            make.trailing.equalTo(-16)
        }
    }

    func setupDataSource(with dataSource: UITableViewDataSource) {
        self.tableView.dataSource = dataSource
    }
    func setupDelegate(with delegate: UITableViewDelegate) {
        self.tableView.delegate = delegate
    }
}
