//
//  GalleryViewController.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 10/4/2022.
//

import UIKit
import Photos

class GalleryViewController: UIViewController {
    
    var service = AuthService.shared
    
    private lazy var exitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Exit", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    private lazy var getAllUsersButton: UIButton = {
        let button = UIButton()
        button.setTitle("All Users", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        return button
    }()
    
    private lazy var safeAreaView = UIView()
    private lazy var headerView = UIView()
    private lazy var profilePicture : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.textColor = .black
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18)
        
        return label
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = .white
        
        return collection
    }()
    
    var currentImage = 0
    var images = [UIImage]()
    let userView = UIView()
    var safeAreaGuide = UILayoutGuide()
    var amountOfPictures = 100

    override func viewDidLoad() {
        super.viewDidLoad()
        getPhotos()
        configureUI()
    }

    @objc private func goBack(){
        service.signOut()
        let controller = CustomNavigationController(rootViewController: LoginViewController())
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false)
    }

    @objc private func getAllUsers(){
        let controller = CustomNavigationController(rootViewController: UsersViewController())
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false)
    }

    fileprivate func getPhotos() {
        let manager = PHImageManager.default()
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = false
        requestOptions.deliveryMode = .highQualityFormat
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        let results: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
        self.currentImage = results.count
        if results.count <= 100 {
            self.amountOfPictures = results.count
        }
        if results.count > 0 {
            for i in 0..<self.amountOfPictures {
                let asset = results.object(at: i)
                let size = CGSize(width: 1000, height: 1000)
                manager.requestImage(for: asset, targetSize: size, contentMode: .aspectFill, options: requestOptions) { (image, _) in
                    if let image = image {
                        self.images.append(image)
                        self.collectionView.reloadData()
                    }
                }
            }
        }
    }

    private func updateUserPhoto(with image: UIImage){
        let strImage = image.jpegData(compressionQuality: 1)?.base64EncodedString() ?? ""
        service.setProfilePicture(string: strImage)
    }

    func stringToImage(string: String) -> UIImage? {
        let imageData = Data(base64Encoded: string)
        guard let image = UIImage(data: imageData!) else {
            return nil
        }
        return image
    }

    private func configureUI() {
        view.backgroundColor = UIColor.white
        view.addSubview(safeAreaView)
        safeAreaView.addSubview(headerView)
        headerView.addSubview(profilePicture)
        profilePicture.layer.cornerRadius = (view.frame.width - 2) / 3 / 2
        headerView.addSubview(userView)
        userView.addSubview(nameLabel)
        safeAreaView.addSubview(collectionView)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        exitButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        getAllUsersButton.addTarget(self, action: #selector(getAllUsers), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitButton)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: getAllUsersButton)
        safeAreaGuide = view.safeAreaLayoutGuide

        nameLabel.translatesAutoresizingMaskIntoConstraints = false

        let user = service.getCurrentUser()
        if user != nil {
            nameLabel.text = "@" + user!.lowercased()
        } else {
            nameLabel.text = ""
        }

        userView.backgroundColor = .white
        userView.translatesAutoresizingMaskIntoConstraints = false
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        safeAreaView.translatesAutoresizingMaskIntoConstraints = false
        safeAreaView.backgroundColor = .blue
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.backgroundColor = .white

        profilePicture.isUserInteractionEnabled = true
        
        safeAreaView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
        safeAreaView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor).isActive = true
        safeAreaView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        safeAreaView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: view.frame.width/3).isActive = true
        profilePicture.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        profilePicture.leadingAnchor.constraint(equalTo: headerView.leadingAnchor).isActive = true
        profilePicture.heightAnchor.constraint(equalToConstant: view.frame.width/3 - 2.0).isActive = true
        profilePicture.widthAnchor.constraint(equalToConstant: view.frame.width/3 - 2.0).isActive = true
        userView.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor).isActive = true
        userView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor).isActive = true
        userView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        userView.topAnchor.constraint(equalTo: headerView.topAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: userView.centerYAnchor).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: userView.centerXAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: safeAreaView.bottomAnchor).isActive = true
        
        guard let image = service.getProfilePicture() else {return}
        if !image.isEmpty {
            profilePicture.image = stringToImage(string: image)
        }
    }
}

extension GalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedController = DetailedPhoto()
        detailedController.iv.image = images[indexPath.row]
        let controller = UINavigationController(rootViewController: detailedController)
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: false)
    }
}

extension GalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.amountOfPictures
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! PhotoCell
        if images.count == self.amountOfPictures {
            cell.initialise(with: images[indexPath.row])
        }
        return cell
    }
}

extension GalleryViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize(width: self.view.frame.width/2 - 1, height: self.view.frame.width/2 - 1)
        return size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
