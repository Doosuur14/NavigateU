//
//  LoginDesignView.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 16.03.2024.
//

import UIKit
import SnapKit

class LoginView: UIView {

    lazy var appName: UILabel = UILabel()
    lazy var email: UITextField = UITextField()
    lazy var password: UITextField = UITextField()
    lazy var login: UIButton = UIButton()
    lazy var redirect: UILabel = UILabel()
    lazy var continueWithGoogle: UIButton = UIButton()
    lazy var termsAndConditions: UILabel = UILabel()
    lazy var conditions: UILabel = UILabel()
    lazy var googleImage: UIImageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpAppName()
        setUpEmail()
        setUpPassword()
        setUpLoginButton()
        setUpRedirect()
        setUpGoogle()
        setUpGoogleImage()
        setUpTerms()
        setUpConditions()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpAppName() {
        addSubview(appName)
        appName.text = "NavigateU"
        appName.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        appName.textColor = UIColor(named: "CustomColor")
        appName.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-10)
            make.centerX.equalToSuperview()
           // make.leading.equalToSuperview().offset(130)
        }
    }

    private func setUpEmail() {
        addSubview(email)
        email.placeholder = "Email"
        email.backgroundColor = .clear
        email.borderStyle = .roundedRect
        email.textColor = UIColor(named: "SubtitleColor")
        email.snp.makeConstraints { make in
            make.top.equalTo(appName.snp.bottom).offset(70)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(360)
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
            make.width.equalTo(360)
            make.height.equalTo(50)
        }
    }

    private func setUpLoginButton() {
        addSubview(login)
        login.setTitle("Login", for: .normal)
        login.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        login.isEnabled = true
        login.backgroundColor = UIColor(named: "CustomColor")
        login.clipsToBounds = true
        login.layer.cornerRadius = 10
        login.snp.makeConstraints { make in
            make.top.equalTo(password.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(360)
            make.height.equalTo(50)
        }
    }

    private func setUpRedirect() {
        addSubview(redirect)
        redirect.text = "or"
        redirect.textColor = UIColor(named: "SubtitleColor")
        redirect.font = UIFont.systemFont(ofSize: 15, weight: .light)
        redirect.snp.makeConstraints { make in
            make.top.equalTo(login.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpGoogle() {
        addSubview(continueWithGoogle)
        continueWithGoogle.setTitle("Continue With Google", for: .normal)
        continueWithGoogle.setTitleColor(.color3, for: .normal)
        continueWithGoogle.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        continueWithGoogle.isEnabled = true
        continueWithGoogle.backgroundColor = UIColor(named: "Color2")
        continueWithGoogle.clipsToBounds = true
        continueWithGoogle.layer.cornerRadius = 10
        continueWithGoogle.snp.makeConstraints { make in
            make.top.equalTo(redirect.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(360)
            make.height.equalTo(50)
        }

    }

    private func setUpTerms() {
        addSubview(termsAndConditions)
        termsAndConditions.text = "By continuing, you agree to Navigate U’s"
        termsAndConditions.textColor = UIColor(named: "SubtitileColor")
        termsAndConditions.font = UIFont.systemFont(ofSize: 10, weight: .light)
        termsAndConditions.snp.makeConstraints { make in
            make.top.equalTo(continueWithGoogle.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpConditions() {
        addSubview(conditions)

        let attributedString = NSMutableAttributedString(string: "Terms of Service and Privacy Policy")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        conditions.attributedText = attributedString
        conditions.text = "Terms of Service and Privacy Policy"
        conditions.textColor = UIColor(named: "SubtitleColor")
        conditions.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        conditions.snp.makeConstraints { make in
            make.top.equalTo(termsAndConditions.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
        }
    }

    private func setUpGoogleImage() {
        addSubview(googleImage)
        googleImage.image = UIImage(named: "googleimage")
        googleImage.alpha = 0.5
        googleImage.contentMode = .scaleAspectFit
        googleImage.snp.makeConstraints { make in
            make.edges.equalTo(continueWithGoogle).inset(15)
            make.leading.equalToSuperview().offset(-200)

        }
    }
}
