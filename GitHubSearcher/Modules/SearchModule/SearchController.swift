//
//  SearchController.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 02.03.2021.
//

import UIKit
import SnapKit

protocol SearchControllerOutput: class {
    func search(name: String)
    func save(repository: Repository)
    func loadMore()
    func didTapOnHistory()
}

class SearchController: UIViewController, AbstractController {
    
    private let cellId = "cellId"
    private let usernameLabel = UILabel()
    private let navigationBarView = UIView()
    private let searchView = UISearchBar()
    private let repositoriesView = UITableView()
    private weak var output: SearchControllerOutput?
    private var repositories: [Repository] = []
    private var isPresentingAlert = false
    
    private let historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(STR.Search.history, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.searchView)
        self.view.addSubview(self.navigationBarView)
        self.view.addSubview(self.repositoriesView)
        self.navigationBarView.addSubview(self.usernameLabel)
        self.navigationBarView.addSubview(self.historyButton)
        
        self.view.backgroundColor = Design.Color.white
        
        self.searchView.delegate = self
        self.repositoriesView.delegate = self
        self.repositoriesView.register(RepositoryCell.self, forCellReuseIdentifier: cellId)
        self.repositoriesView.dataSource = self
        self.repositoriesView.estimatedRowHeight = 60.0
        self.repositoriesView.rowHeight = UITableView.automaticDimension
        
        self.historyButton.addTarget(self, action: #selector(self.didTapOnHistory), for: .touchUpInside)
        
        self.setupConstraints()
    }
    
    @objc private func didTapOnHistory() {
        self.output?.didTapOnHistory()
    }
    
    public func setup(username: String) {
        self.usernameLabel.text = username
    }
    
    public func setup(output: SearchControllerOutput) {
        self.output = output
    }
    
    public func show(repositories: [Repository]) {
        self.repositories.append(contentsOf: repositories)
        self.repositories.sort { (first, second) -> Bool in
            first.starCount ?? 0 > second.starCount ?? 0
        }
        self.repositoriesView.reloadData()
        self.searchView.isHidden = false
    }
    
    public func showAlert() {
        self.isPresentingAlert = true
        let alert = UIAlertController(title: STR.Search.Error.title, message: STR.Search.Error.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: STR.Search.Error.ok, style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            self.isPresentingAlert = false
        }))
        self.searchView.isHidden = false
        self.searchView.text = ""
        if self.isPresentingAlert {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    public func showHistory(repositories: [Repository]) {
        let vc = HistoryViewController(repositories: repositories)
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupConstraints() {
        self.navigationBarView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(Design.Spacing.d40)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(60)
        }
        self.usernameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().inset(Design.Spacing.d20)
        }
        self.searchView.snp.makeConstraints {
            $0.top.equalTo(self.navigationBarView.snp.bottom).offset(Design.Spacing.d4)
            $0.left.right.equalToSuperview()
        }
        self.repositoriesView.snp.makeConstraints {
            $0.top.equalTo(self.searchView.snp.bottom)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(Design.Spacing.d24)
        }
        self.historyButton.snp.makeConstraints {
            $0.left.equalToSuperview().offset(Design.Spacing.d20)
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(60)
        }
    }
    
}

extension SearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text else { return }
        self.repositories.removeAll()
        self.repositoriesView.reloadData()
        self.output?.search(name: name)
        searchBar.isHidden = true
        self.view.endEditing(true)
    }
}

extension SearchController: UITableViewDelegate, UITableViewDataSource {
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
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == self.repositoriesView {
        
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height) {
                self.output?.loadMore()
            }
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.repositories[indexPath.row]
        self.output?.save(repository: model)
        guard let string = model.htmlUrl, let link = URL(string: string) else { return }
        UIApplication.shared.open(link)
    }
}
