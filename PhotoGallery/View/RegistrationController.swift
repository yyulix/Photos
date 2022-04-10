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

    private lazy var registerButton : CustomRoundedButton = {
        let button = CustomRoundedButton(title: "Sign Up")
        button.button.addTarget(self, action: #selector(SignUp), for: .touchUpInside)
        return button
    }()

    private lazy var signInButton : AttributedCustomButton = {
        let button = AttributedCustomButton(firstPart: "Are you already registered? ", secondPart: "Sign In")
        button.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
        return button
    }()
    
    private let authService = AuthService.shared
    
    // MARK: - Public Methods
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        view.backgroundColor = .white
        title = "Registration"
        navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationItem.hidesBackButton = true
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
    
    @objc func SignIn(){
        let controller = LoginViewController()
        navigationController?.pushViewController(controller, animated: false)
    }

    @objc func SignUp() {
        guard let username = usernameInputView.textField.text else {
            let alert = UIAlertController(title: nil, message: "No username", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: false, completion: nil)
            }))
            self.present(alert, animated: true)
            return
        }

        guard let password = passwordInputView.textField.text else {
            let alert = UIAlertController(title: nil, message: "No password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: false, completion: nil)
            }))
            self.present(alert, animated: true)
            return
        }

        guard let retypedPassword = retypePasswordInputView.textField.text else {
            let alert = UIAlertController(title: nil, message: "No password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: false, completion: nil)
            }))
            self.present(alert, animated: true)
            return
        }
        
        if password != retypedPassword {
            let alert = UIAlertController(title: nil, message: "Passwords are not the same", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: false, completion: nil)
            }))
            self.present(alert, animated: true)
            return
        }
        authService.initUserDefaults()
        if authService.signUp(username: username, password: password) == true {
            let controller = GalleryViewController()
            navigationController?.pushViewController(controller, animated: false)
        } else {
            let alert = UIAlertController(title: nil, message: "Error!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alert.dismiss(animated: false, completion: nil)
            }))
            self.present(alert, animated: true)
        }
    }
}
