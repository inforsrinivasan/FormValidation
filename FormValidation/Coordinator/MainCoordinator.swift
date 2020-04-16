//
//  MainCoordinator.swift
//  FormValidation
//
//  Created by Srinivasan Rajendran on 2020-04-15.
//  Copyright © 2020 Srinivasan Rajendran. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinating {

    let navigationController: UINavigationController
    let window: UIWindow

    init(window: UIWindow, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.window = window
    }

    func start() {
        let loginForm = LoginFormViewController()
        navigationController.pushViewController(loginForm, animated: true)
    }

}
