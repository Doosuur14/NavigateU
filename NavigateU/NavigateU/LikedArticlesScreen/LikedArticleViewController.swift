//
//  LikedArticleViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 29.07.2024.
//

import UIKit

protocol LikedArticleProtocol: AnyObject {
    var likedArticleView: LikedArticleView? {get set}
    var viewModel: LikedArticlesViewModel { get }

}

class LikedArticleViewController: UIViewController, UITableViewDataSource,
                                  UITableViewDelegate, LikedarticleViewDelegate, LikedArticleProtocol {

    var likedArticleView: LikedArticleView?
    let viewModel: LikedArticlesViewModel

    init(likedArticleView: LikedArticleView? = nil, viewModel: LikedArticlesViewModel) {
        self.likedArticleView = likedArticleView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchLikedArticles()
        likedArticleView?.tableView.reloadData()
    }

    private func setupView() {
        likedArticleView = LikedArticleView(frame: view.bounds)
        view = likedArticleView
        likedArticleView?.delegate = self
        likedArticleView?.setupDelegate(with: self)
        likedArticleView?.setupDataSource(with: self)
        likedArticleView?.tableView.separatorStyle = .none
        likedArticleView?.tableView.register(LikedArticleCell.self,
                                             forCellReuseIdentifier: LikedArticleCell.LikedArticleReuseIdentifier)
        view.backgroundColor = .systemBackground
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.configureCell(tableView, cellForRowAt: indexPath)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(viewModel.heightForRowAt())
    }

    func didPressSortButton() {
        print("button pressed to sort.")
        viewModel.sortArticlesByLikes()
        likedArticleView?.tableView.reloadData()
    }
}
