//
//  LoginViewModal.swift
//  Pazarama
//
//  Created by utku on 1.11.2022.
//

import Foundation
import FirebaseRemoteConfig

class LoginViewModal{
    
    // MARK: - Properties
    private let remoteConfig = RemoteConfig.remoteConfig()

    
    // MARK: - Methods
    func fetchRemote(){
        let defaults:[String:NSObject] = ["sign_up_available" : true as NSObject]

        remoteConfig.setDefaults(defaults)
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { (status, error) in
            if status == .success {
                print("Config fetched!\(status)")
                //self.updateSignUp(value: status.rawValue)
            }
            else {
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        
    })
    }
}
