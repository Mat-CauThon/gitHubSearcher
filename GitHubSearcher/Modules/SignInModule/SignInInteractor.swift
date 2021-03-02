//
//  SignInInteractor.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import Foundation

class SignInInteractor {
    
    private var presenter: SignInPresenter
    private(set) weak var output: SignInModuleOutput?
    
    init(presenter: SignInPresenter) {
        self.presenter = presenter
    }
    
    func setupOutput(output: SignInModuleOutput) {
        self.output = output
    }

}
