//
//  SignInModule.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import UIKit
import AbstractModule

class SignInModule: AbstractModule {
    
    var interactor: SignInInteractor
    var presenter: SignInPresenter
    
    var rootViewController: UIViewController {
        get {
            return presenter.controller
        }
    }
    
    init() {
        let presenter = SignInPresenter()
        self.presenter = presenter
        self.interactor = SignInInteractor(presenter: presenter)
        presenter.setupInteractor(interactor: self.interactor)
    }
    
}
