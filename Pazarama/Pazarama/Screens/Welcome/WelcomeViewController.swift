//
//  WelcomeViewController.swift
//  Pazarama
//
//  Created by utku on 2.11.2022.
//

import UIKit
import OnboardKit

class WelcomeViewController: UIViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(navigationController)
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        let firstPage = OnboardPage(title: " ", imageName: "pazarama", description: "Pazarama is an e-commerce app that you can find everything you need.")
        let secondPage = OnboardPage(title: " ", imageName: "ecommerce", description: "Find what you need from the comfort of your home between thousands of products.")
        let thirdPage = OnboardPage(title: " ", imageName: "online", description: "Also, you can find travel and hotel deals.",advanceButtonTitle: "Go Back", actionButtonTitle: "Get Started", action: {_ in 
            // find login view controller and go
            Core.shared.setIsNotNewUser()
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.presentedViewController?.present(loginVC, animated: true)
        })
        let pages = [firstPage, secondPage, thirdPage]
       
        let boldTitleFont = UIFont.systemFont(ofSize: 32.0, weight: .bold)
        let mediumTextFont = UIFont.systemFont(ofSize: 17.0, weight: .semibold)
        let appearanceConfiguration = OnboardViewController.AppearanceConfiguration(
            tintColor: .systemPink,
            titleColor: .systemPink,
            textColor: .black,
            backgroundColor:.systemBackground,
            titleFont:boldTitleFont,
            textFont: mediumTextFont)
        let onboardingVC = OnboardViewController(pageItems: pages, appearanceConfiguration: appearanceConfiguration)
        onboardingVC.modalPresentationStyle = .fullScreen
        onboardingVC.presentFrom(self, animated: true)
    }


    private func finishOnboarding() {
        print("Func")
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        //vc.present(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

