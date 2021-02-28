//
//  LaunchEngine.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import UIKit

final class LaunchEngine {
    
    private weak var window: UIWindow?
    private let mainModule: MainModule
    
    init(window: UIWindow?) {
        self.window = window
        self.mainModule = MainModule()
    }
    
    public func mainFlow() {
        self.window?.rootViewController = self.mainModule.rootViewController
        self.window?.makeKeyAndVisible()
        self.mainModule.mainFlow()
    }
    
}
