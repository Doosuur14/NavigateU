//
//  EditProfileView.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 15.08.2024.
//

import UIKit

protocol EditProfileDelegate: AnyObject {
    func didTapSaveButton()
}

class EditProfileView: UIView {

    lazy var firstName: UITextField = UITextField()
    lazy var lastName: UITextField = UITextField()
    lazy var email: UITextField = UITextField()
    lazy var password: UITextField = UITextField()
    lazy var countryOfOrigin: UITextField = UITextField()
    lazy var cityOfResidence: UITextField = UITextField()
    lazy var saveButton: UIButton = UIButton()

    weak var delegate: EditProfileDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
       setupFunc()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupFunc() {
        setupFirstName()
        setupLastName()
        setupEmail()
        setupPassword()
        setupCountryOfOrigin()
        setupResidence()
        setupSaveButton()
    }

    private func setupFirstName() {
        addSubview(firstName)
        firstName.placeholder = "First Name"
        firstName.backgroundColor = .clear
        firstName.borderStyle = .roundedRect
        firstName.textColor = UIColor(named: "SubtitleColor")
        firstName.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }

    private func setupLastName() {
        addSubview(lastName)
        lastName.placeholder = "Last Name"
        lastName.backgroundColor = .clear
        lastName.borderStyle = .roundedRect
        lastName.textColor = UIColor(named: "SubtitleColor")
        lastName.snp.makeConstraints { make in
            make.top.equalTo(firstName.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)

        }
    }

    private func setupEmail() {
        addSubview(email)
        email.placeholder = "Email"
        email.backgroundColor = .clear
        email.autocapitalizationType = .none
        email.isUserInteractionEnabled = false
        email.borderStyle = .roundedRect
        email.textColor = UIColor(named: "SubtitleColor")
        email.snp.makeConstraints { make in
            make.top.equalTo(lastName.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }

    private func setupPassword() {
        addSubview(password)
        password.placeholder = "Password"
        password.backgroundColor = .clear
        password.borderStyle = .roundedRect
        password.textColor = UIColor(named: "SubtitleColor")
        password.snp.makeConstraints { make in
            make.top.equalTo(email.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }

    private func setupCountryOfOrigin() {
        addSubview(countryOfOrigin)
        countryOfOrigin.placeholder = "Nationality"
        countryOfOrigin.backgroundColor = .clear
        countryOfOrigin.borderStyle = .roundedRect
        countryOfOrigin.textColor = UIColor(named: "SubtitleColor")
        countryOfOrigin.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }

    private func setupResidence() {
        addSubview(cityOfResidence)
        cityOfResidence.placeholder = "City Of Residence"
        cityOfResidence.backgroundColor = .clear
        cityOfResidence.borderStyle = .roundedRect
        cityOfResidence.textColor = UIColor(named: "SubtitleColor")
        cityOfResidence.snp.makeConstraints { make in
            make.top.equalTo(countryOfOrigin.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }

    private func setupSaveButton() {
        addSubview(saveButton)
        saveButton.setTitle("Save Changes", for: .normal)
        saveButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        saveButton.backgroundColor = UIColor(named: "CustomColor")
        saveButton.clipsToBounds = true
        let action = UIAction { [weak self] _ in
            self?.delegate?.didTapSaveButton()
        }
        saveButton.addAction(action, for: .touchUpInside)
        saveButton.layer.cornerRadius = 10
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(cityOfResidence.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }

}

extension EditProfileView: UITextFieldDelegate {
    func configureForm() -> UserData? {
        let isFirstNameEmpty = firstName.isEmptyTextField()
        let isLastNameEmpty = lastName.isEmptyTextField()
        let isEmailEmpty = email.isEmptyTextField()
        let isPasswordEmpty = password.isEmptyTextField()
        let isCountryEmpty = countryOfOrigin.isEmptyTextField()
        let isCityEmpty = cityOfResidence.isEmptyTextField()
        if isEmailEmpty || isPasswordEmpty || isFirstNameEmpty || isLastNameEmpty || isCountryEmpty || isCityEmpty  {
            return nil
        }
        return UserData(
            firstname: firstName.text,
            lastname: lastName.text,
            emailText: email.text,
            passwordText: password.text,
            country: countryOfOrigin.text,
            city: cityOfResidence.text
        )
    }
}

    struct UserData {
        let firstname: String?
        let lastname: String?
        let emailText: String?
        let passwordText: String?
        let country: String?
        let city: String?
    }

