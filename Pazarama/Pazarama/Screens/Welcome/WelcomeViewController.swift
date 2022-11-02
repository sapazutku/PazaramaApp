//
//  WelcomeViewController.swift
//  Pazarama
//
//  Created by utku on 2.11.2022.
//

import UIKit

class WelcomeViewController: UIViewController{
        
        override func viewDidLoad() {
            super.viewDidLoad()
            print("WelcomeViewController")
            Core.shared.setIsNotNewUser()
        }
}
