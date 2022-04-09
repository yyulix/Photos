//
//  CustomRoundedButton.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 9/4/2022.
//

import UIKit

final class CustomRoundedButton: UIView {

    private struct UIConstants {
        static let height = 50.0
        static let width = 200.0
        static let fontSize = 16.0
    }

    // MARK: - Public Properties
    // MARK: - Private Properties
    // MARK: - Initialisers
    
    init(title: String, target: Any? = nil, action: Selector? = nil) {

        super.init(frame: .zero)

        heightAnchor.constraint(equalToConstant: UIConstants.height).isActive = true

        let button = UIButton(type: .system)
        if let target = target, let action = action {
            button.addTarget(target, action: action, for: .touchUpInside)
        }

        button.layer.cornerRadius = UIConstants.height / 2;
        button.backgroundColor = UIColor.AppColors.accentColor
        
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: UIConstants.fontSize)
        
        button.tintColor = .white

        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: UIConstants.width).isActive = true
        button.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    // MARK: - Private methods
}
