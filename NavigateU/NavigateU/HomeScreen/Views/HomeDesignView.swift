//
//  HomeDesignView.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 17.03.2024.
//

import UIKit
import SnapKit

final class HomeDesignView: UIView {

    var alreadyRegisteredaction: (() -> Void)?
    var getStartedButtonAction: (() -> Void)?
    private lazy var appName: UILabel = UILabel()
    private lazy var slogan: UILabel = UILabel()
    private lazy var slogan2: UILabel = UILabel()
    lazy var getStarted: UIButton = UIButton()
    lazy var alreadyRegistered: UIButton = UIButton()
    private lazy var terms: UILabel = UILabel()
    private lazy var conditions: UILabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpFunctions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpFunctions() {
        setupAppName()
        setFirstSloganLabel()
        setSecondSloganLabel()
        setupGetstartedButton()
        setupAlreadyReg()
        setupTerms()
        setupConditions()
    }

    private func setupAppName() {
        addSubview(appName)
        appName.text = "NavigateU"
        appName.font = UIFont.systemFont(ofSize: 30, weight: .regular)
        appName.textColor = UIColor(named: "CustomColor")
        appName.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(-10)
            make.leading.equalToSuperview().offset(134)
            make.trailing.equalToSuperview().offset(-134)
            make.centerX.equalToSuperview()
        }
    }

    private func setFirstSloganLabel() {
        addSubview(slogan)
        slogan.text = "We make settling down as"
        slogan.font = UIFont.systemFont(ofSize: 15, weight: .light)
        slogan.textColor = UIColor(named: "SubtitleColor")
        slogan.snp.makeConstraints { make in
            make.top.equalTo(appName.snp.bottom).offset(70)
            make.leading.equalToSuperview().offset(120)
            make.trailing.equalToSuperview().offset(-120)
            make.centerX.equalToSuperview()
        }
    }

    private func setSecondSloganLabel() {
        addSubview(slogan2)
        slogan2.text = "foreign student in Russia easier!"
        slogan2.font = UIFont.systemFont(ofSize: 15, weight: .light)
        slogan2.textColor = UIColor(named: "SubtitleColor")
        slogan2.snp.makeConstraints { make in
            make.top.equalTo(slogan.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(100)
            make.trailing.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview()
        }
    }

    private func setupGetstartedButton() {
        addSubview(getStarted)
        getStarted.setTitle("Get Started", for: .normal)
        getStarted.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        getStarted.backgroundColor = UIColor(named: "CustomColor")
        getStarted.clipsToBounds = true
        getStarted.layer.cornerRadius = 10
        let action = UIAction {  [weak self] _ in
            self?.getStartedButtonAction?()
        }
        getStarted.addAction(action, for: .touchUpInside)
        getStarted.snp.makeConstraints { make in
            make.top.equalTo(slogan2.snp.bottom).offset(50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
    }
}

    private func setupAlreadyReg() {
        addSubview(alreadyRegistered)
        alreadyRegistered.setTitle("I already have an account", for: .normal)
        alreadyRegistered.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .light)
        alreadyRegistered.setTitleColor(.color3, for: .normal)
        alreadyRegistered.isEnabled = true
        alreadyRegistered.backgroundColor = UIColor(named: "Color2")
        alreadyRegistered.clipsToBounds = true
        alreadyRegistered.layer.cornerRadius = 10
        let action = UIAction { [weak self] _ in
            self?.alreadyRegisteredaction?()
        }
        alreadyRegistered.addAction(action, for: .touchUpInside)
        alreadyRegistered.snp.makeConstraints { make in
            make.top.equalTo(getStarted.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    private func setupTerms() {
        addSubview(terms)
        terms.text = "By continuing, you agree to Navigate U’s"
        terms.textColor = UIColor(named: "SubtitileColor")
        terms.font = UIFont.systemFont(ofSize: 10, weight: .light)
        terms.snp.makeConstraints { make in
            make.top.equalTo(alreadyRegistered.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(110)
            make.trailing.equalToSuperview().offset(-110)
            make.centerX.equalToSuperview()
        }
    }

    private func setupConditions() {
        addSubview(conditions)
        let attributedString = NSMutableAttributedString(string: "Terms of Service and Privacy Policy")
        attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length))
        conditions.attributedText = attributedString
        conditions.text = "Terms of Service and Privacy Policy"
        conditions.textColor = UIColor(named: "SubtitleColor")
        conditions.font = UIFont.systemFont(ofSize: 10, weight: .semibold)
        conditions.snp.makeConstraints { make in
            make.top.equalTo(terms.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(110)
            make.trailing.equalToSuperview().offset(-110)
            make.centerX.equalToSuperview()
        }
    }
}
