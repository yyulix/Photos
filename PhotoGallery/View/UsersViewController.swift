//
//  UsersViewController.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 10/4/2022.
//

import UIKit

class UsersViewController: UIViewController {

    private struct UIConstants {
        static let titleSize = 24.0
        static let height = 30.0
        static let rowHeight = 30.0
    }

    let service = AuthService.shared

    var users : [String] = []
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = UIColor.white
        table.dataSource = self
        table.delegate = self
        table.translatesAutoresizingMaskIntoConstraints = false
        table.separatorStyle = .singleLine
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.global(qos: .userInteractive).async {
            self.users = self.service.getAllUsers()
        }

        configureUI()
    }

    private func configureUI() {

        self.title = "Users"

        users = service.getAllUsers()

        navigationController!.navigationBar.barTintColor = UIColor.white
        view.backgroundColor = UIColor.white
        navigationController!.navigationBar.tintColor = UIColor.white
        navigationController!.navigationItem.hidesBackButton = false
        navigationController!.navigationBar.standardAppearance.shadowColor = .white
        navigationController!.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.backgroundColor = UIColor.AppColors.accentColor

        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rowHeight = UIConstants.rowHeight

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension UsersViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        cell.detailTextLabel?.font = UIFont.systemFont(ofSize: 18.0)
        cell.detailTextLabel?.text = "@" + users[indexPath.row].lowercased()
        cell.detailTextLabel?.textColor = UIColor.black
        var image = service.getProfilePicture(username: users[indexPath.row])?.toImage() ?? UIImage(named: "placeholder.png")
        cell.imageView?.image = image
        cell.imageView?.sizeToFit()
        cell.imageView?.clipsToBounds = true
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.frame.size.height = 200
        cell.imageView?.frame.size.width = 200
        cell.backgroundColor = UIColor.white
        cell.tintColor = UIColor.gray
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
