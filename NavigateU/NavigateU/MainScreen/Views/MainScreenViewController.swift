//
//  MainScreenViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 21.03.2024.
//

import UIKit

final class MainScreenViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let remoteDataSource = DocumentRemoteDataSource()
    var mainView: MainScreenView?
    let viewModel = MainScreenViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }

    private func setUpView() {
        mainView = MainScreenView(frame: view.bounds)
        view = mainView
        mainView?.setupDelegate(with: self)
        mainView?.setupDataSource(with: self)
        mainView?.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        view.backgroundColor = .white

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.configureCell(tableView, cellForRowAt: indexPath)

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        let articleId = indexPath.row + 1
        remoteDataSource.fetchArticleDetails(articleId: articleId) { [weak self] result in
            switch result {
                case .success(let article):
         DispatchQueue.main.async {
            let documentVC = DocumentViewController(article: article)
            self?.navigationController?.pushViewController(documentVC, animated: true)
         }
            case .failure(let error):
             print("Error fetching article details for specific section: \(error)")
       }
    }
}
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(viewModel.heightForRowAt())
    }
}
