//
//  AuthService.swift
//  PhotoGallery
//
//  Created by Yulia Popova on 10/4/2022.
//

import Foundation

struct AuthService {

    static let shared = AuthService()

    private let defaults = UserDefaults.standard

    enum userDefaultKeys : String {
        case users = "list_of_users"
        case currentUser = "current_user"
        case userPhoto = "user_photo"
    }

    func setCurrentUser(_ login:String) {
        defaults.set(login, forKey: userDefaultKeys.users.rawValue)
    }

    func getCurrentUser() -> String? {
        guard let username = defaults.string(forKey: userDefaultKeys.currentUser.rawValue) else { return nil }
        return username
    }

    func setProfilePicture(string: String) {

        guard let currentUser = getCurrentUser() else { return }

        var profilePictures = defaults.dictionary(forKey: userDefaultKeys.userPhoto.rawValue) as! [String:String]
        profilePictures[currentUser] = string
        defaults.set(profilePictures, forKey: userDefaultKeys.userPhoto.rawValue)
    }

    func getProfilePicture() -> String? {

        guard let user = getCurrentUser() else {return nil}

        let dictionary = defaults.dictionary(forKey: userDefaultKeys.userPhoto.rawValue) as! [String:String]
        return dictionary[user]
    }

    func initUserDefaults() -> Bool {

        if defaults.dictionary(forKey: userDefaultKeys.userPhoto.rawValue) == nil {
            let dictionary : [String:String] = ["" : ""]
            defaults.set(dictionary, forKey: userDefaultKeys.userPhoto.rawValue)
        }

        guard defaults.dictionary(forKey: userDefaultKeys.users.rawValue) != nil else {
            let dictionary : [String:String] = ["" : ""]
            defaults.set(dictionary, forKey: userDefaultKeys.users.rawValue)
            return false
        }

        if defaults.string(forKey: userDefaultKeys.currentUser.rawValue) != nil {
            guard let currentUser = defaults.string(forKey: userDefaultKeys.currentUser.rawValue) else { return false }
            guard let users = defaults.dictionary(forKey: userDefaultKeys.users.rawValue) else { return false }
            guard let currentPassword = users[currentUser] as? String else { return false }
            if signIn(username: currentUser, password: currentPassword) { return true }
        }
        return false
    }

    func signIn(username: String, password: String) -> Bool {
        guard let users = defaults.dictionary(forKey: userDefaultKeys.users.rawValue) else { return false }
        guard let currentUser = users[username] else { return false }
        if currentUser as! String == password { return true }
        return false
    }

    func signUp(username: String, password: String) -> Bool {
        var dictionary = defaults.dictionary(forKey: userDefaultKeys.users.rawValue) as! [String:String]
        if dictionary[username] == nil {
            dictionary[username] = password
            defaults.set(dictionary, forKey: userDefaultKeys.users.rawValue)
            return true
        }
        return false
    }

    func signOut() {
        defaults.set("", forKey: userDefaultKeys.currentUser.rawValue)
    }
}
