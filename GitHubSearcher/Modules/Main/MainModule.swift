//
//  MainModule.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import UIKit
import AbstractModule

class MainModule: AbstractModule {
    
    var rootViewController: UIViewController {
        get {
            return self.presenter.navigationController
        }
    }
    
    public var interactor: MainInteractor
    public var presenter: MainPresenter
    
    init() {
        let presenter = MainPresenter()
        self.presenter = presenter
        self.interactor = MainInteractor(presenter: presenter)
        presenter.setupInteractor(interactor: self.interactor)
    }
    
    public func mainFlow() {
        self.interactor.mainFlow()
    }
    
}
