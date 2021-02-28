//
//  RepositoriesLoader.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import Foundation

protocol NetworkLoader {
    var urlPath: String { get set }
    var manager: NetworkManager? { get set }
    func loadData()
}

class RepositoriesLoader: NetworkLoader {
    
    weak var manager: NetworkManager?
    var urlPath: String
    
    init(path: String) {
        self.urlPath = path
    }
    
    func loadData() {
        
    }
    
    public func setupManager(manager: NetworkManager) {
        self.manager = manager
    }
}
