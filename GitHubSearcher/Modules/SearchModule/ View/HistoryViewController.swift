//
//  HistoryViewController.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 02.03.2021.
//

import UIKit
import SnapKit

class HistoryViewController: UIViewController, AbstractController {
    
    private let cellId = "cellId"
    private let repositoriesView = UITableView()
    private var repositories: [Repository] = []
    
    init(repositories: [Repository]) {
        super.init(nibName: nil, bundle: nil)
        self.repositories = repositories
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Design.Color.white
        self.view.addSubview(self.repositoriesView)
        self.setupConstraints()
        self.repositoriesView.delegate = self
        self.repositoriesView.register(RepositoryCell.self, forCellReuseIdentifier: cellId)
        self.repositoriesView.dataSource = self
        self.repositoriesView.estimatedRowHeight = 60.0
        self.repositoriesView.rowHeight = UITableView.automaticDimension
        self.repositoriesView.reloadData()
    }
    
    func setupConstraints() {
        self.repositoriesView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Design.Spacing.d20)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
}


extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.repositories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId") as! RepositoryCell
        
        // set the text from the data model
        let model = self.repositories[indexPath.row]
        cell.setup(fullName: model.fullName ?? "Unnamed", starsCount: model.starCount ?? 0)
        return cell
    }
}
