//
//  SignInPresenter.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import UIKit

final class SignInPresenter {
    
    private weak var interactor: SignInInteractor?
    public var controller: SignInController
    
    init() {
        self.controller = SignInController()
    }
    
    public func setupInteractor(interactor: SignInInteractor) {
        self.interactor = interactor
    }
    
}
