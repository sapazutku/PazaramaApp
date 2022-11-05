//
//  LoginViewController.swift
//  Pazarama
//
//  Created by utku on 27.10.2022.
//

import UIKit
import SnapKit
import Lottie
import FirebaseFirestore
import FirebaseAuth
import Drops
import FirebaseRemoteConfig

class LoginViewController: UIViewController {
    
    // MARK: - Properties
    
    private let remoteConfig = RemoteConfig.remoteConfig()
    
    private let loginViewModal = LoginViewModal()
    
    private var animationView = LottieAnimationView()
    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        // take from the assets
        iv.image = UIImage(named: "pazarama" )
        iv.contentMode = .scaleAspectFit
        return iv
    }()

    private let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()

    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.isSecureTextEntry = true
        //tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()

    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Don't have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Sign Up", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.systemPink]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowSignUp), for: .touchUpInside)
        return button
    }()


    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchRemote()
        configureUI()
    }

    
    // MARK: - Helpers

    func configureUI() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black

        view.backgroundColor = .white

        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }

        let stack = UIStackView(arrangedSubviews: [emailTextField, passwordTextField, loginButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually

        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(150)
        }

        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }

        // animation
        animationView = LottieAnimationView(name: "ecommerce")
        animationView.frame = CGRect(x: 0, y: 400, width: view.frame.width, height: 300)
        animationView.contentMode = .scaleToFill
        animationView.loopMode = .loop
        animationView.play()
        view.addSubview(animationView)
        view.sendSubviewToBack(animationView)
    }
    // MARK: - Methods
  
    func fetchRemote(){
        let defaults:[String:NSObject] = ["sign_up_available" : true as NSObject]

        remoteConfig.setDefaults(defaults)
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings

        self.remoteConfig.fetch(withExpirationDuration: 0, completionHandler: { (status, error) in
            if status == .success {
                self.updateSignUp(value: status.rawValue)
            }
            else {
                print("Error: \(error?.localizedDescription ?? "No error available.")")
            }
        
    })
    }

    func updateSignUp(value:Int){
        if value == 1{
            self.dontHaveAccountButton.isHidden = false
        } else {
            self.dontHaveAccountButton.isHidden = true
            
        }
    }

    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false
        if isFormValid {
            loginButton.isEnabled = true
            loginButton.backgroundColor = .systemPink
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = .lightGray
        }
    }


  @objc func handleLogin() {
      guard let emailTextField = emailTextField.text else {return}
      guard let password = passwordTextField.text else {return}
      
      FirebaseAuth.Auth.auth().signIn(withEmail: emailTextField, password: password, completion: {result, error in
          if (error != nil) {
            let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return
          }
          else{
            Drops.show(Drop(title: "Welcome", subtitle: "You are logged in", icon: UIImage(systemName: "figure.wave")))
            let vc = TabBarController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
              
          }
      })
      
  }

    @objc func handleShowSignUp() {
        let controller = RegisterViewController()
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
    }
}
