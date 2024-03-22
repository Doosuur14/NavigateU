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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpSearchBar() {
        addSubview(searchBar)
        searchBar.placeholder = "Search"
        searchBar.searchBarStyle = .prominent
        searchBar.showsCancelButton = true
        searchBar.backgroundColor = .clear


    }

    private func setUpTableView() {
        addSubview(tableView)
        

    }
}
