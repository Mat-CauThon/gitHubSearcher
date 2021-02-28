//
//  MainInteractor.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import Foundation

class MainInteractor {
    
    private var presenter: MainPresenter
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
    }
    
    public func mainFlow() {
        self.presenter.showSignIn()
    }
    
}
