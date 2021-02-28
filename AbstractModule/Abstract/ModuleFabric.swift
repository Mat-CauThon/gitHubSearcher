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
        case signIn
    }
    
    private var signIn: ModuleHolder<SignInModule>?
    
    public func setupNewModule(type: ModuleType) -> AbstractModule? {
        switch type {
            case .signIn:
                self.signIn?.destroyModule()
                self.signIn = ModuleHolder<SignInModule>(module: SignInModule())
                return self.signIn?.abstractModule
        }
    }
    
}
