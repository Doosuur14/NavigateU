//
//  MainScreenViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 21.03.2024.
//

import UIKit
import CoreData

final class MainScreenViewController: UIViewController, UITableViewDataSource,
                                      UITableViewDelegate, UISearchBarDelegate {

    let remoteDataSource = DocumentRemoteDataSource()
    var mainView: MainScreenView?
    let viewModel: MainScreenViewModel

    init(viewModel: MainScreenViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.mainView?.tableView.reloadData()
                self?.updateNoResultsLabel()
            }
        }
    }

    private func setupView() {
        mainView = MainScreenView(frame: view.bounds)
        view = mainView
        mainView?.setupDelegate(with: self)
        mainView?.setupDataSource(with: self)
        mainView?.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        mainView?.tableView.separatorStyle = .none
        mainView?.searchBar.delegate = self
        mainView?.label.frame = view.bounds
        view.backgroundColor = .systemBackground
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.configureCell(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
        let selectedContent = viewModel.filteredContent[indexPath.row]
        let articleId = selectedContent.id

        let context = CoreDataManager.shared.persistentContainer.viewContext

        remoteDataSource.fetchArticleDetails(articleId: articleId) { [weak self] result in
            switch result {
            case .success(let articleResponse):
                DispatchQueue.main.async {
                    let newArticle = Article(articleResponse: articleResponse, context: context)
                    try? context.save()

                    let documentVC = DocumentViewController(article: newArticle)
                    self?.navigationController?.pushViewController(documentVC, animated: true)
                }
            case .failure(let error):
                self?.handleArticleFetchError(error)
            }
        }
    }



    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(viewModel.heightForRowAt())
    }


    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchPost(searchText)
    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mainView?.searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        mainView?.searchBar.resignFirstResponder()
        viewModel.cancelButtonClicked()
    }


    private func updateNoResultsLabel() {
        mainView?.label.isHidden = viewModel.numberOfRowsInSection() != 0
    }

    private func handleArticleFetchError(_ error: Error) {
        let customError: ArticleServiceError

        if error is URLError {
            customError = .networkError
        } else {
            customError = .unknown
        }

        switch customError {
        case .noData:
            AlertManager.shared.showNoDataError(viewCon: self)
        case .networkError:
            AlertManager.shared.showNoNetworkError(viewCon: self)
        case .unknown:
            AlertManager.shared.showUnknownError(viewCon: self)
        }
    }
}
