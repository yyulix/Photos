//
//  DetailedPhoto.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 10/4/2022.
//

import UIKit

class DetailedPhoto: UIViewController {

    var service = AuthService.shared

    var iv = UIImageView()

    private var container = UIView()

    private var containerLayoutGuide = UILayoutGuide()

    private let exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Back", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()

    private let updatePhotoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Profile Photo", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        container.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(container)
        container.addSubview(iv)
        exitButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        updatePhotoButton.addTarget(self, action: #selector(updatePhoto), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: updatePhotoButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitButton)
        containerLayoutGuide = view.safeAreaLayoutGuide
        container.topAnchor.constraint(equalTo: containerLayoutGuide.topAnchor).isActive = true
        container.bottomAnchor.constraint(equalTo: containerLayoutGuide.bottomAnchor).isActive = true
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        iv.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        iv.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        iv.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        iv.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
    }
    
    
    @objc private func updatePhoto() {
        let codedImage = iv.image?.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        service.setProfilePicture(string: codedImage)
        let alert = UIAlertController(title: nil, message: "Photo was updated!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            alert.dismiss(animated: false, completion: nil)
        }))
        self.present(alert, animated: true)
    }
    
    @objc private func back() {
        let gallery = GalleryViewController()
        let controller = UINavigationController(rootViewController: gallery)
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false)
    }
    
    convenience init(image: UIImage){
        self.init()
        iv.image = image
    }
}
