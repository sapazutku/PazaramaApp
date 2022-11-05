//
//  UserDefaults+Extension.swift
//  Pazarama
//
//  Created by utku on 27.10.2022.
//

import Foundation

extension UserDefaults {
    // user profile photo
    static let profilePhoto = "profilePhoto"
    func getProfilePhoto() -> Data? {
        return data(forKey: UserDefaults.profilePhoto)
    }

    func setProfilePhoto(data: Data) {
        set(data, forKey: UserDefaults.profilePhoto)
    }

    // user name

    static let userName = "userName"
    func getUserName() -> String? {
        return string(forKey: UserDefaults.userName)
    }

    func setUserName(name: String) {
        set(name, forKey: UserDefaults.userName)
    }

    // user email

    static let userEmail = "userEmail"
    func getUserEmail() -> String? {
        return string(forKey: UserDefaults.userEmail)
    }

    func setUserEmail(email: String) {
        set(email, forKey: UserDefaults.userEmail)
    }
    
}