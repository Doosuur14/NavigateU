//
//  DocumentViewController.swift
//  NavigateU
//
//  Created by Faki Doosuur Doris on 07.05.2024.
//

import UIKit

class DocumentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    var documentView: DocumentView?
    let documentModel = DocumentModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        loadMockData()
    }

    private func setUpView() {
        documentView = DocumentView(frame: view.bounds)
        view = documentView
        documentView?.setupDelegate(with: self)
        documentView?.setupDataSource(with: self)
        documentView?.tableView.register(DocumentTableViewCell.self, forCellReuseIdentifier: DocumentTableViewCell.reuseIdentifierForDoc)
        documentView?.tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseIdentifier)
        view.backgroundColor = .white
    }

    private func loadMockData() {
        documentModel.setupMockData { error in
            if let error = error {
                print("Error fetching mock data: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.documentView?.tableView.reloadData()
                }
            }

        } 
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        documentModel.numberOfRowsInSection()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(documentModel.heightForRowAt())
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.selectionStyle = .none
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        documentModel.configureCell(tableView, cellForRowAt: indexPath)
    }

}
