//
//  SearchService.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 02.03.2021.
//

import Foundation
import GitHubNetwork

protocol SearchServiceOutput: class {
    func loaded(items: [Repository]?)
}

class SearchService {
    
    private var firstSearcher = SearchAPI()
    private var secondSearcher = SearchAPI()
    private var firstSearcherPage = 1
    private var secondSearcherPage = 2
    private let repositoriesPerPageNumber = 15
    private var semaphore = DispatchSemaphore(value: 1)
    private weak var output: SearchServiceOutput?
    private var savedName: String = ""
    
    public func search(name: String) {
        
        self.savedName = name
        self.firstSearcherPage = 1
        self.secondSearcherPage = 2
        
        self.search(name: name, with: self.firstSearcher, at: self.firstSearcherPage)
        self.search(name: name, with: self.secondSearcher, at: self.secondSearcherPage)
        
        self.firstSearcherPage += 2
        self.secondSearcherPage += 2
    }
    
    public func loadMore() {
        self.search(name: self.savedName, with: self.firstSearcher, at: self.firstSearcherPage)
        self.search(name: self.savedName, with: self.secondSearcher, at: self.secondSearcherPage)
        
        self.firstSearcherPage += 2
        self.secondSearcherPage += 2
    }
    
    public func setup(output: SearchServiceOutput) {
        self.output = output
    }
    
    private func search(name: String, with searcher: SearchAPI, at page: Int) {
        let queue = DispatchQueue.global(qos: .utility)
        queue.async { [unowned self] in
            self.semaphore.wait()
            searcher.searchRepositories(q: name, page: page, per_page: self.repositoriesPerPageNumber, sort: .stars, order: .desc) { [weak self] (response, error) in
                if let response = response {
                    let repositories = response.items?.map({ (item) -> Repository in
                        return Repository(fullName: item.fullName, htmlUrl: item.htmlUrl, starCount: item.stargazersCount, authorImageURL: item.owner?.avatarUrl)
                    })
                    DispatchQueue.main.async {
                        self?.output?.loaded(items: repositories)
                    }
                } else {
                    self?.output?.loaded(items: nil)
                    print(error ?? "")
                }
                self?.semaphore.signal()
            }
        }
    }
    
}

