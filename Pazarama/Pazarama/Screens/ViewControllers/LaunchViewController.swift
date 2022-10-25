//
//  LaunchViewController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit
import Lottie
class LaunchViewController: UIViewController {

    // pazarama icon
    private let pazaramaImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "pazarama")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var animationView = LottieAnimationView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemIndigo
        view.backgroundColor = .systemIndigo
        // image view
        view.addSubview(pazaramaImageView)
        pazaramaImageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        pazaramaImageView.center = view.center


        // animation
        animationView = LottieAnimationView(name: "loading")
        animationView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        // under the pazarama icon
        animationView.center = CGPoint(x: pazaramaImageView.center.x, y: pazaramaImageView.center.y - 100)
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
