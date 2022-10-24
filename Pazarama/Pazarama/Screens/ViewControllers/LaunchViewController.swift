//
//  LaunchViewController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit
import Lottie
class LaunchViewController: UIViewController {
    
    var animationView = LottieAnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemIndigo
        view.backgroundColor = .systemIndigo
        // load init under assets folder
        animationView = LottieAnimationView(name: "ecommerce")
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animationView.center = view.center
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
}
