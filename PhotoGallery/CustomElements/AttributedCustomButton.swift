//
//  AttributedCustomButton.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 9/4/2022.
//

import UIKit

final class AttributedCustomButton: UIButton {
    
    private struct UIConstants {
        static let fontSize = 16.0
    }

    // MARK: - Public Properties
    // MARK: - Private Properties
    // MARK: - Initialisers

    init(firstPart: String, secondPart: String) {
        super.init(frame: .zero)
        let attributedTitle = NSMutableAttributedString(
            string: firstPart,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIConstants.fontSize),
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
        )
        attributedTitle.append(NSAttributedString(
            string: secondPart,
            attributes: [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: UIConstants.fontSize),
                NSAttributedString.Key.foregroundColor: UIColor.AppColors.accentColor
            ]
        ))
        setAttributedTitle(attributedTitle, for: .normal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public methods
    // MARK: - Private methods
}
