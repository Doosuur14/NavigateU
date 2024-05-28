//
//  RegistrationScreenView.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 19.03.2024.
//

import UIKit

final class RegistrationScreenView: UIView {

    lazy var appName: UILabel = UILabel()
    lazy var firstName: UITextField = UITextField()
    lazy var lastName: UITextField = UITextField()
    lazy var email: UITextField = UITextField()
    lazy var password: UITextField = UITextField()
    lazy var countryOfOrigin: UITextField = UITextField()
    lazy var cityOfResidence: UITextField = UITextField()
    lazy var terms: UILabel = UILabel()
    lazy var conditions: UILabel = UILabel()
    lazy var registerButton: UIButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpFunctions()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpFunctions() {
        setUpAppname()
        setUpFirstName()
        setUpLastName()
        setUpEmail()
        setUpPassword()
        setUpCountryOfOrigin()
        setUpResidence()
        setUpTerms()
        setUpConditions()
        setUpRegisterButton()
    }

    private func setUpAppname() {
        addSubview(appName)
        appName.text = "NavigateU"
        appName.textColor = UIColor(named: "CustomColor")
        appName.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        appName.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpFirstName() {
        addSubview(firstName)
        firstName.placeholder = "First Name"
        firstName.backgroundColor = .clear
        firstName.borderStyle = .roundedRect
        firstName.textColor = UIColor(named: "SubtitleColor")
        firstName.snp.makeConstraints { make in
            make.top.equalTo(appName.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }

    private func setUpLastName() {
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

    private func setUpEmail() {
        addSubview(email)
        email.placeholder = "Email"
        email.backgroundColor = .clear
        email.autocapitalizationType = .none
        email.borderStyle = .roundedRect
        email.textColor = UIColor(named: "SubtitleColor")
        email.snp.makeConstraints { make in
            make.top.equalTo(lastName.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
    }

    private func setUpPassword() {
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

    private func setUpCountryOfOrigin() {
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

    private func setUpResidence() {
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

    private func setUpTerms() {
        addSubview(terms)
        terms.text = "By selecting Agree and continue, you agree to"
        terms.font = UIFont.systemFont(ofSize: 10, weight: .light)
        terms.textColor = UIColor(named: "SubtitleColor")
        terms.snp.makeConstraints { make in
            make.top.equalTo(cityOfResidence.snp.bottom).offset(30)
            make.centerX.equalToSuperview()

        }
    }

    private func setUpConditions() {
        addSubview(conditions)
        conditions.text = "Navigate U’s Terms of Service and Privacy Policy"
        conditions.font = UIFont.systemFont(ofSize: 10, weight: .light)
        conditions.textColor = UIColor(named: "SubtitileColor")
        conditions.snp.makeConstraints { make in
            make.top.equalTo(terms.snp.bottom).offset(5)
            make.centerX.equalToSuperview()

        }
    }

    private func setUpRegisterButton() {
        addSubview(registerButton)
        registerButton.setTitle("Agree and Continue", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        registerButton.backgroundColor = UIColor(named: "CustomColor")
        registerButton.clipsToBounds = true
        registerButton.layer.cornerRadius = 10
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(conditions.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(50)
       }   
    }
}
