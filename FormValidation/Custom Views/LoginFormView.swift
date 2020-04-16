//
//  LoginFormView.swift
//  FormValidation
//
//  Created by Srinivasan Rajendran on 2020-04-16.
//  Copyright © 2020 Srinivasan Rajendran. All rights reserved.
//

import UIKit
import Combine

class LoginFormView: UIView {

    var userNameValidationView = UserNameValidationView()
    let passwordTextField = UITextField()
    let confirmPasswordTextField = UITextField()
    let button = UIButton(type: .roundedRect)
    var cancellables = [AnyCancellable]()
    var password: AnyPublisher<String, Never>?
    var confirmPassword: AnyPublisher<String, Never>?

    override init(frame: CGRect) {
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 20
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        button.isEnabled = false
        setUpSubViews()
        setUpPassword()
        setUpConfirmPassword()
        setUpConstraints()
        bind()
    }

    private func setUpSubViews() {
        addSubview(userNameValidationView)
        addSubview(button)
        addSubview(passwordTextField)
        addSubview(confirmPasswordTextField)
    }

    private func setUpPassword() {
        passwordTextField.layer.borderWidth = 2
        passwordTextField.layer.cornerRadius = 12
        passwordTextField.layer.borderColor = UIColor.systemGray2.cgColor
        passwordTextField.placeholder = "Password"
    }

    private func setUpConfirmPassword() {
        confirmPasswordTextField.layer.borderWidth = 2
        confirmPasswordTextField.layer.cornerRadius = 12
        confirmPasswordTextField.layer.borderColor = UIColor.systemGray2.cgColor
        confirmPasswordTextField.placeholder = "Confirm Password"
    }

    private func setUpConstraints() {
        userNameValidationView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 120))
        passwordTextField.anchor(top: userNameValidationView.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 60))
        confirmPasswordTextField.anchor(top: passwordTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 60))
        button.anchor(top: confirmPasswordTextField.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 50, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 50))
        button.centerXInSuperview()
    }

    private func bind() {
        userNameValidationView.isValidUserName?.assign(to: \UserNameValidationView.userNameValidationLabel.isHidden, on: userNameValidationView).store(in: &cancellables)
        password = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: passwordTextField)
            .map { ($0.object as! UITextField).text! }.eraseToAnyPublisher()
        confirmPassword = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: confirmPasswordTextField)
            .map { ($0.object as! UITextField).text! }.eraseToAnyPublisher()
        let latestPublisher = Publishers.CombineLatest(password!, confirmPassword!)
            .map { (p1, p2) -> Bool in
                (p1 == p2) && p1.count > 4
        }.eraseToAnyPublisher()
        Publishers.CombineLatest(latestPublisher, userNameValidationView.isValidUserName!)
            .map { $0 && $1 }
            .assign(to: \LoginFormView.button.isEnabled, on: self).store(in: &cancellables)
    }
}
