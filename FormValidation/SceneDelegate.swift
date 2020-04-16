//
//  SceneDelegate.swift
//  FormValidation
//
//  Created by Srinivasan Rajendran on 2020-04-15.
//  Copyright © 2020 Srinivasan Rajendran. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let navigation = UINavigationController()
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        window.rootViewController = navigation
        window.makeKeyAndVisible()
        let mainCoordinator = MainCoordinator(window: window, navigationController: navigation)
        mainCoordinator.start()
    }


}

