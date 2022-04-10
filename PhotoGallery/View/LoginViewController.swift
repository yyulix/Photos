//
//  LoginViewController.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 9/4/2022.
//

import UIKit

class LoginViewController: UIViewController {

    private struct UIConstants {
        static let spacing = 12.0
        static let paddingTop = 44.0 + (UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0)
    }

    let authService = AuthService.shared
    
    // MARK: - Public Property
    // MARK: - Private Property
    private lazy var usernameInputView = InputField(labelImage: UIImage.AuthIcons.personIcon, placeholderText: "Enter username")
    private var passwordInputView : InputField {
        lazy var passwordInput = InputField(labelImage: UIImage.AuthIcons.lockIcon, placeholderText: "Enter password")
        passwordInput.textField.isSecureTextEntry = true
        return passwordInput
    }

    private lazy var signInButton : CustomRoundedButton = {
        let button = CustomRoundedButton(title: "Sign In")
        button.button.addTarget(self, action: #selector(SignIn), for: .touchUpInside)
        return button
    }()

    private lazy var signUpButton : AttributedCustomButton = {
        let button = AttributedCustomButton(firstPart: "Are you not registered? ", secondPart: "Sign Up")
        button.addTarget(self, action: #selector(SignUp), for: .touchUpInside)
        return button
    }()

    // MARK: - Public Methods
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        navigationController?.navigationItem.hidesBackButton = true
        if authService.getCurrentUser() != "" {
            let controller = CustomNavigationController(rootViewController: GalleryViewController())
            controller.modalPresentationStyle = .fullScreen
            self.present(controller, animated: false)
        }
        
        view.backgroundColor = .white
        title = "Sign In"
        configureInputsStackView()
    }

    // MARK: - Private Methods
    private func configureInputsStackView() {
        let stack = UIStackView(arrangedSubviews: [usernameInputView, passwordInputView, signInButton, signUpButton])
        stack.axis = .vertical
        stack.spacing = UIConstants.spacing
        view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.topAnchor.constraint(equalTo: view.topAnchor, constant: UIConstants.paddingTop + UIConstants.spacing).isActive = true
        stack.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        stack.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    }
    
    @objc func SignUp(){
        let controller = CustomNavigationController(rootViewController: RegistrationController())
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false)
    }

    @objc func SignIn() {
        guard let username = usernameInputView.textField.text else { return }
        guard let password = passwordInputView.textField.text else { return }
        if username != "" {
            if authService.signIn(username: username, password: password) == true {
                let controller = GalleryViewController()
                navigationController?.pushViewController(controller, animated: false)
            } else {
                print("error")
            }
        }
    }
}
