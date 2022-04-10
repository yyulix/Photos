//
//  CustomTabBarViewController.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 10/4/2022.
//

import UIKit

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let calendarController = GalleryViewController()
        let dataFetcher = UsersViewController()

        let calendarBarItem = UITabBarItem(
            title: "Calendar",
            image: UIImage(systemName: "calendar"),
            selectedImage: UIImage(systemName: "calendar")
        )

        calendarController.tabBarItem = calendarBarItem

        let dataFetcherBarItem = UITabBarItem(
            title: "Data",
            image: UIImage(systemName: "list.bullet.indent"),
            selectedImage: UIImage(systemName: "list.bullet.indent")
        )

        dataFetcher.tabBarItem = dataFetcherBarItem

        viewControllers = [dataFetcher, calendarController]
    }
}
