//
//  ModuleFabric.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import Foundation

final class ModuleHolder<Module: AbstractModule> {
    
    public var module: Module?
    
    public var abstractModule: AbstractModule? {
        get {
            return module
        }
    }
    
    init(module: Module?) {
        self.module = module
    }
    
    public func destroyModule() {
        self.module = nil
    }
    
}

final class ModuleFabric {
    
    enum ModuleType {
        case signIn(SignInModuleOutput)
        case search(String)
    }
    
    private var signIn: ModuleHolder<SignInModule>?
    private var search: ModuleHolder<SearchModule>?
    
    public func setupNewModule(type: ModuleType) -> AbstractModule? {
        switch type {
            case .signIn(let output):
                self.signIn?.destroyModule()
                self.signIn = ModuleHolder<SignInModule>(module: SignInModule(output: output))
                return self.signIn?.abstractModule
            case .search(let username):
                self.search?.destroyModule()
                self.search = ModuleHolder<SearchModule>(module: SearchModule(username: username))
                return self.search?.abstractModule
        }
    }
    
}
