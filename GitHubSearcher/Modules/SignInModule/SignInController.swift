//
//  SignInController.swift
//  GitHubSearcher
//
//  Created by Roman Mishchenko on 28.02.2021.
//

import UIKit
import GitHubNetwork
class SignInController: UIViewController, AbstractController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = .blue
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupConstraints() {}

}
