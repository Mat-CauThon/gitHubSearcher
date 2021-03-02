//
//  SignInModule.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 01.03.2021.
//

import UIKit

enum SignInModuleAction {
    case login(String)
}

protocol SignInModuleOutput: class {
    func didProduce(action: SignInModuleAction)
}

class SignInModule: AbstractModule {
    
    var rootViewController: UIViewController {
        get {
            return self.presenter.controller
        }
    }
    
    public var interactor: SignInInteractor
    public var presenter: SignInPresenter
    
    init(output: SignInModuleOutput) {
        let presenter = SignInPresenter()
        self.presenter = presenter
        self.interactor = SignInInteractor(presenter: presenter)
        self.interactor.setupOutput(output: output)
        presenter.setupInteractor(interactor: self.interactor)
    }
    
    
}

