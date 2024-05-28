//
//  HomeScreenView.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 17.03.2024.
//

import UIKit

protocol HomeScreenDelegate: AnyObject {
    func pressedGetStartedButton()
    func pressedRegistrateredButton()
}

final class HomeScreenView: UIView {

    weak var delegate: HomeScreenDelegate?
    lazy var backgroundImage: UIImageView = UIImageView()
    let secondView = HomeDesignView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpFunctions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpFunctions() {
        setUpBackgroundImage()
        setUpSecondView()
    }

    private func setUpBackgroundImage() {
        addSubview(backgroundImage)
        backgroundImage.image = UIImage(named: "HomescreenNavigateU")
        backgroundImage.contentMode = .scaleAspectFit
        backgroundImage.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(300)
        }
    }

    private func  setUpSecondView() {
        addSubview(secondView)
        backgroundColor = .white
        secondView.backgroundColor = .white
        secondView.layer.cornerRadius = 10
        secondView.snp.makeConstraints { make in
            make.top.equalTo(backgroundImage.snp.bottom).offset(30)
            make.leading.equalToSuperview()
            make.height.equalTo(300)
        }
    }
}
