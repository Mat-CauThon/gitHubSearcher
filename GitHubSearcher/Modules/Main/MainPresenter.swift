//
//  MainPresenter.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import UIKit

class MainPresenter {
    
    private weak var interactor: MainInteractor?
    private(set) var navigationController: UINavigationController
    
    private let moduleFabric = ModuleFabric()
    
    init() {
        self.navigationController = UINavigationController()
        self.navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    public func setupInteractor(interactor: MainInteractor) {
        self.interactor = interactor
    }
    
    public func showSignIn(output: SignInModuleOutput) {
        guard let module = self.moduleFabric.setupNewModule(type: .signIn(output)) else { return }
        let controller = module.rootViewController
        self.navigationController.setViewControllers([controller], animated: true)
    }
    
    public func showSearch(username: String) {
        guard let module = self.moduleFabric.setupNewModule(type: .search(username)) else { return }
        let controller = module.rootViewController
//        controller.modalPresentationStyle = .fullScreen
        self.navigationController.setViewControllers([controller], animated: true)
    }
    
}
