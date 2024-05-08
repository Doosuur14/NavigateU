//
//  DocumentView.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 07.05.2024.
//

import UIKit

class DocumentView: UIView {

    lazy var tableView: UITableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpTableView()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
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
