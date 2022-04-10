//
//  StringToImage.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 10/4/2022.
//

import UIKit

extension String {
    func toImage() -> UIImage? {
        if let data = Data(base64Encoded: self, options: .ignoreUnknownCharacters){
            return UIImage(data: data)
        }
        return nil
    }
}
