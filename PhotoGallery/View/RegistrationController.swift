//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 9/4/2022.
//

import UIKit
import Photos

class RegistrationController: UIViewController {

    private struct UIConstants {
        static let spacing = 12.0
        static let paddingTop = 44.0 + (UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
    }

    // MARK: - Public Property
    // MARK: - Private Property
    private lazy var usernameInputView = InputField(labelImage: UIImage.AuthIcons.personIcon, placeholderText: "Enter username")
    private var passwordInputView : InputField {
        lazy var passwordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: "Enter password")
        passwordInput.textField.isSecureTextEntry = true
        return passwordInput
    }
    private var retypePasswordInputView : InputField {
        lazy var retypePasswordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: "Retype password")
        retypePasswordInput.textField.isSecureTextEntry = true
        return retypePasswordInput
    }
    private lazy var registerButton = CustomRoundedButton(title: "Sign Up")
    private lazy var signInButton = AttributedCustomButton(firstPart: "Are you already registered? ", secondPart: "Sign In")

    // MARK: - Public Methods
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        view.backgroundColor = .white
        title = "Registration"
        configureInputsStackView()
    }

    // MARK: - Private Methods
    private func configureInputsStackView() {
        let stack = UIStackView(arrangedSubviews: [usernameInputView, passwordInputView, retypePasswordInputView, registerButton, signInButton])
        stack.axis = .vertical
        stack.spacing = UIConstants.spacing
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstants.paddingTop + UIConstants.spacing).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
}
