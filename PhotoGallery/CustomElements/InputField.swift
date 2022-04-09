//
//  InputField.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 9/4/2022.
//

import UIKit

final class InputField: UIView, UITextFieldDelegate {

    private struct UIConstants {
        static let height = 50.0
        static let width = 200.0
        
        static let iconWidth = 20.0
        static let iconHeight = 20.0
        
        static let paddingLeft = 28.0
        static let paddingRight = -28.0
        static let paddingBottom = -8.0
        
        static let space = 8.0
        
        static let dividerWidth = 1.0
    }
    
    // MARK: - Public Properties
    
    public lazy var textField = UITextField()
    
    // MARK: - Private Properties
    
    private let icon = UIImageView()
    private let dividerView = UIView()
    
    // MARK: - Initialisers
    
    init(labelImage: UIImage? = nil, keyboardType: UIKeyboardType = .default, placeholderText: String) {
        super.init(frame: .zero)
        
        heightAnchor.constraint(equalToConstant: UIConstants.height).isActive = true
        addIcon(labelImage: labelImage)
        addTextfield(placeholderText: placeholderText)
        addDivider()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    
    // MARK: - Private methods
    
    private func addIcon(labelImage: UIImage? = nil) {
        addSubview(icon)
        icon.image = labelImage
        icon.tintColor = UIColor.AppColors.accentColor
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.widthAnchor.constraint(equalToConstant: UIConstants.iconWidth).isActive = true
        icon.heightAnchor.constraint(equalToConstant: UIConstants.iconHeight).isActive = true
        icon.leftAnchor.constraint(equalTo: leftAnchor, constant: UIConstants.paddingLeft).isActive = true
        icon.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIConstants.paddingBottom).isActive = true
    }
    
    private func addTextfield(placeholderText: String) {
        addSubview(textField)
        
        textField.autocorrectionType = .no
        textField.textColor = .black
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholderText,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray]
        )
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: UIConstants.space).isActive = true
        textField.rightAnchor.constraint(equalTo: rightAnchor, constant: UIConstants.paddingRight).isActive = true
        textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: UIConstants.paddingBottom).isActive = true
    }


    private func addDivider() {
        addSubview(dividerView)
        dividerView.backgroundColor = UIColor.AppColors.accentColor
        dividerView.translatesAutoresizingMaskIntoConstraints = false

        dividerView.heightAnchor.constraint(equalToConstant: UIConstants.dividerWidth).isActive = true
        dividerView.leftAnchor.constraint(equalTo: leftAnchor, constant: UIConstants.paddingLeft).isActive = true
        dividerView.rightAnchor.constraint(equalTo: rightAnchor, constant: UIConstants.paddingRight).isActive = true
        dividerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
