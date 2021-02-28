//
//  MainPresenter.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import UIKit

class MainPresenter {
    
    private(set) var navigationController: UINavigationController
    private weak var interactor: MainInteractor?
    
    private let moduleFabric = ModuleFabric()
    
    init() {
        self.navigationController = UINavigationController()
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    public func setupInteractor(interactor: MainInteractor) {
        self.interactor = interactor
    }
    
    public func showSignIn() {
        guard let module = self.moduleFabric.setupNewModule(type: .signIn) else { return }
        let vc = module.rootViewController
        self.navigationController.setViewControllers([vc], animated: true)
    }
    
}
