//
//  PhotoCell.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 10/4/2022.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    var iv = UIImageView()
    func initialise(with image: UIImage){
        self.backgroundColor = .white
        iv = UIImageView(frame: self.bounds)
        iv.image = image
        iv.clipsToBounds = true
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iv)
    }
}
