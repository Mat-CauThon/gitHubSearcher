//
//  AppDelegate.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var launchEngine: LaunchEngine?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.startMainFlow()
        return true
    }

    private func startMainFlow() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        
        let engine = LaunchEngine(window: window)
        engine.mainFlow()
        self.launchEngine = engine
    }
    
}

