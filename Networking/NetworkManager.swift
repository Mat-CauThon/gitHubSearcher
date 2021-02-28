//
//  NetworkManager.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import Foundation

public final class NetworkManager {
    
    private var firstLoader: NetworkLoader
    private var secondLoader: NetworkLoader
    
    private let repoPath: String = ""
    
    init() {
        self.firstLoader = RepositoriesLoader(path: repoPath)
        self.secondLoader = RepositoriesLoader(path: repoPath)
    }
    
}
