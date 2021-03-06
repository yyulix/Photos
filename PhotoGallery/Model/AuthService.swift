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
        case users = "list_of_users_"
        case currentUser = "current_user_"
        case userPhoto = "user_photo_"
    }

    private func setCurrentUser(username: String) {
        defaults.set(username, forKey: userDefaultKeys.currentUser.rawValue)
    }

    func signOut() {
        setCurrentUser(username: "")
    }

    func getCurrentUser() -> String? {
        let username = defaults.string(forKey: userDefaultKeys.currentUser.rawValue)
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
        guard let dictionary = defaults.dictionary(forKey: userDefaultKeys.userPhoto.rawValue) as? [String:String] else {
            return nil
        }
        guard let picture = dictionary[user] else {
            return nil
        }
        return picture
    }

    func getProfilePicture(username: String) -> String? {
        
        let dictionary = defaults.dictionary(forKey: userDefaultKeys.userPhoto.rawValue) as! [String:String]
        return dictionary[username]
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

    func getAllUsers() -> [String] {
        guard let users = defaults.dictionary(forKey: userDefaultKeys.users.rawValue) else { return []}
        
        let array = Array(users.keys)
        var result : [String] = []
        
        for user in array {
            if user != "" {
                result.append(user)
            }
        }
        return result
    }

    func signIn(username: String, password: String) -> Bool {
        guard let users = defaults.dictionary(forKey: userDefaultKeys.users.rawValue) else { return false }
        guard let currentUser = users[username] else { return false }
        if currentUser as! String == password {
            setCurrentUser(username: username)
            return true
        }
        return false
    }

    func signUp(username: String, password: String) -> Bool {
        let name = username.lowercased()
        var dictionary = defaults.dictionary(forKey: userDefaultKeys.users.rawValue) as! [String:String]
        if dictionary[name] == nil {
            dictionary[name] = password
            defaults.set(dictionary, forKey: userDefaultKeys.users.rawValue)
            setCurrentUser(username: name)
            return true
        }
        return false
    }
}
