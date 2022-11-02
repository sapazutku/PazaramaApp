//
//  LaunchViewController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit
import Lottie
import FirebaseAuth
class LaunchViewController: UIViewController {

    // pazarama icon
    private let pazaramaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pazarama2")
        imageView.contentMode = .center
        return imageView
    }()
    

    
    var animationView = LottieAnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        // image view
        view.addSubview(pazaramaImageView)
        pazaramaImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        pazaramaImageView.center = view.center


        // animation
        animationView = LottieAnimationView(name: "loading")
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        // under the pazarama icon
        animationView.center = CGPoint(x: pazaramaImageView.center.x, y: pazaramaImageView.center.y + 100)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        controlUser()
    }

    func controlUser(){
        if Auth.auth().currentUser != nil {
            // user is logged in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                let vc = TabBarController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
        else if Core.shared.isNewUser() {
            // user is not logged in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                let vc = WelcomeViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }
        }
        else {
            // user is not logged in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                let login = LoginViewController()
                login.modalPresentationStyle = .fullScreen
                self.present(login, animated: true)
            }
        }
    }
    
}

class Core {
    static let shared = Core()

    func isNewUser() -> Bool {
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }

    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }


}
