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
    
    func controlUser(){
        if Auth.auth().currentUser != nil {
            let tabBar = TabBarController()
            tabBar.modalPresentationStyle = .fullScreen
            present(tabBar, animated: true)
        }else{
            let login = LoginViewController()
            login.modalPresentationStyle = .fullScreen
            present(login, animated: true)
        }
    }
    
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
    
    
    
}
