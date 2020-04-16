//
//  UserNameValidationView.swift
//  FormValidation
//
//  Created by Srinivasan Rajendran on 2020-04-16.
//  Copyright © 2020 Srinivasan Rajendran. All rights reserved.
//

import UIKit
import Combine

class UserNameValidationView: UIView {

    let userNameTextField = UITextField()
    let userNameValidationLabel = UILabel()

    var isValidUserName: AnyPublisher<Bool, Never>?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUp() {
        setUpLabel()
        setUpTextField()
        configureConstraints()
        bind()
    }

    private func configureConstraints() {
        userNameTextField.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 0))
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        userNameTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        userNameValidationLabel.anchor(top: userNameTextField.bottomAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .zero, size: .init(width: 0, height: 0))
        userNameValidationLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameValidationLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
    }

    private func setUpLabel() {
        addSubview(userNameValidationLabel)
        userNameValidationLabel.text = "Username should have atleast 5 characters"
        userNameValidationLabel.textColor = .red
        userNameValidationLabel.textAlignment = .center
    }

    private func setUpTextField() {
        addSubview(userNameTextField)
        userNameTextField.becomeFirstResponder()
        userNameTextField.borderStyle = .none
        userNameTextField.layer.cornerRadius = 10.0
        userNameTextField.layer.borderColor = UIColor.systemGray2.cgColor
        userNameTextField.layer.borderWidth = 2.0
        userNameTextField.layer.masksToBounds = true
        userNameTextField.placeholder = "Username"
    }

    private func bind() {
        isValidUserName = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: userNameTextField)
        .map { (($0.object as! UITextField).text!.count > 4) }
        .eraseToAnyPublisher()
    }

}

