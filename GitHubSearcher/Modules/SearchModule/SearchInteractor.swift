//
//  SearchInteractor.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 02.03.2021.
//

import Foundation

class SearchInteractor {
    
    private var presenter: SearchPresenter
    private var searchService = SearchService()
    private var coreDataService = CoreDataService()
    private var repositories: [Repository] = []
    private var savedRepositories: [Repository] = []
    
    init(presenter: SearchPresenter) {
        self.presenter = presenter
        self.searchService.setup(output: self)
        self.savedRepositories = self.coreDataService.getRepositories()
    }
    
    func searchRepositories(for name: String) {
        self.repositories = []
        self.searchService.search(name: name)
    }
    func loadMoreRepositories() {
        self.searchService.loadMore()
    }
    func save(repository: Repository) {
        coreDataService.save(repository: repository)
        self.savedRepositories.append(repository)
        self.removeExcess()
    }
    
    private func removeExcess() {
        if self.savedRepositories.count > AppConstants.maxNumberOfSavedRepositories {
            self.savedRepositories.removeFirst()
        }
    }
    
    func loadHistory() {
        if self.savedRepositories.isEmpty {
            let repos = self.coreDataService.getRepositories()
            self.presenter.showHistory(repositories: repos)
        } else {
            self.presenter.showHistory(repositories: self.savedRepositories)
        }
    }
    
}

extension SearchInteractor: SearchServiceOutput {
    func loaded(items: [Repository]?) {
        guard let repositories = items, repositories.count != 0 else {
            if self.repositories.isEmpty {
                self.presenter.showAlert()
            }
            return
        }
        self.repositories.append(contentsOf: repositories)
        self.presenter.show(repositories: repositories)
    }
}
