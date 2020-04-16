//
//  LoginFormViewController.swift
//  FormValidation
//
//  Created by Srinivasan Rajendran on 2020-04-15.
//  Copyright © 2020 Srinivasan Rajendran. All rights reserved.
//

import UIKit

class LoginFormViewController: UIViewController {

    let loginFormView = LoginFormView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(loginFormView)
        loginFormView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 100, left: 10, bottom: 10, right: 10), size: .zero)
    }

}
