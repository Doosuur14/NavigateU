//
//  LikedArticleView.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.07.2024.
//

import UIKit

protocol LikedarticleViewDelegate: AnyObject {
    func didPressSortButton()
}

class LikedArticleView: UIView {

    lazy var tableView: UITableView = UITableView()
    lazy var label: UILabel = UILabel()
    lazy var sortButton: UIButton = UIButton(type: .system)

    weak var delegate: LikedarticleViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
        setupTableView()
        setupLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupButton() {
        addSubview(sortButton)
        sortButton.setTitle("Sort by Likecount", for: .normal)
        sortButton.setTitleColor(.custom, for: .normal)
        let action = UIAction { [weak self] _ in
            self?.delegate?.didPressSortButton()
        }
        sortButton.addAction(action, for: .touchUpInside)
        sortButton.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(sortButton.snp.bottom).offset(10)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }

    private func setupLabel() {
        addSubview(label)
        label.text = "No Liked Found"
        label.textAlignment = .center
        label.textColor = UIColor(named: "SubtitleColor")
        label.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        label.isHidden = true
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    func setupDataSource(with dataSource: UITableViewDataSource) {
        self.tableView.dataSource = dataSource
    }
    
    func setupDelegate(with delegate: UITableViewDelegate) {
        self.tableView.delegate = delegate
    }
}
