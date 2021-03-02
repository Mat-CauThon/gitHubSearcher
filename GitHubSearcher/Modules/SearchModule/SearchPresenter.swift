//
//  SearchPresenter.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 02.03.2021.
//

import Foundation

class SearchPresenter {
    
    private(set) var controller = SearchController()
    private weak var interactor: SearchInteractor?
    
    init(username: String) {
        self.controller.setup(username: username)
        self.controller.setup(output: self)
    }
    
    public func setup(interactor: SearchInteractor) {
        self.interactor = interactor
    }
    
    public func show(repositories: [Repository]) {
        self.controller.show(repositories: repositories)
    }
    
    public func showAlert() {
        self.controller.showAlert()
    }
    
    public func showHistory(repositories: [Repository]) {
        self.controller.showHistory(repositories: repositories)
    }
}

extension SearchPresenter: SearchControllerOutput {
    func search(name: String) {
        self.interactor?.searchRepositories(for: name)
    }
    func loadMore() {
        self.interactor?.loadMoreRepositories()
    }
    func save(repository: Repository) {
        self.interactor?.save(repository: repository)
    }
    func didTapOnHistory() {
        self.interactor?.loadHistory()
    }
}
