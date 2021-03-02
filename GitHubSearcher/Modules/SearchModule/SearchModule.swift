//
//  SearchModule.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 02.03.2021.
//

import UIKit

class SearchModule: AbstractModule {
    
    var rootViewController: UIViewController {
        get {
            self.presenter.controller
        }
    }
    
    var presenter: SearchPresenter
    var interactor: SearchInteractor
    
    init(username: String) {
        self.presenter = SearchPresenter(username: username)
        self.interactor = SearchInteractor(presenter: self.presenter)
        self.presenter.setup(interactor: self.interactor)
    }
    
}
