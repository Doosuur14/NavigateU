//
//  MainScreenView.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 21.03.2024.
//

import UIKit

final class MainScreenView: UIView {

    lazy var searchBar: UISearchBar = UISearchBar()
    lazy var tableView: UITableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSearchBar()
        setUpTableView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpSearchBar() {
        addSubview(searchBar)
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        searchBar.backgroundColor = .clear
        searchBar.becomeFirstResponder()
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.equalTo(10)
            make.trailing.equalTo(-10)
            make.height.equalTo(35)
        }
    }

    private func setUpTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }

    func setupDataSource(with dataSource: UITableViewDataSource) {
        self.tableView.dataSource = dataSource
    }
    func setupDelegate(with delegate: UITableViewDelegate) {
        self.tableView.delegate = delegate
    }
}
