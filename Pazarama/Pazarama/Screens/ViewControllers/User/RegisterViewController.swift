//
//  RegisterViewController.swift
//  Pazarama
//
//  Created by utku on 27.10.2022.
//

import UIKit
import SnapKit
import FirebaseAuth
import FirebaseFirestore
import Drops
class RegisterViewController: UIViewController {
    
    // MARK: - Properties

    
    private let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "pazarama")
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Username"
        tf.borderStyle = .roundedRect
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.addTarget(self, action: #selector(handleTextInputChange), for: .editingChanged)
        return tf
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
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.layer.cornerRadius = 5
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSAttributedString(string: "Log in", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.systemPink]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        
        let stack = UIStackView(arrangedSubviews: [usernameTextField, emailTextField, passwordTextField, registerButton])
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(200)
        }
        
        view.addSubview(dontHaveAccountButton)
        dontHaveAccountButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
        
    }
    // MARK: - Methods
    
    @objc func handleTextInputChange() {
        let isFormValid = emailTextField.text?.isEmpty == false && passwordTextField.text?.isEmpty == false && usernameTextField.text?.isEmpty == false
        if isFormValid {
            registerButton.isEnabled = true
            registerButton.backgroundColor = .systemPink
        } else {
            registerButton.isEnabled = false
            registerButton.backgroundColor = .lightGray
        }
    }
    
    @objc func handleSignUp() {
        
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let username = usernameTextField.text else { return }
        
        // Create Auth User

        FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                Drops.show(Drop(title: "Error", subtitle: error.localizedDescription, icon: UIImage(systemName: "xmark.circle.fill")))
                return
            }
            
            print("Successfully created user: ", result?.user.uid ?? "")
            guard let uid = result?.user.uid else { return }
            
            // Saving to the FireStore
            let values = ["email": email, "username": username, "password": password]
            Firestore.firestore().collection("users").document(uid).setData(values) { error in
                if let error = error {
                    Drops.show(Drop(title: "Error", subtitle: error.localizedDescription, icon: UIImage(systemName: "xmark.circle.fill")))
                    return
                }
                // Update for display name
                let changeRequest = result?.user.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges(completion: { error in
                    if let error = error {
                        Drops.show(Drop(title: "Error", subtitle: error.localizedDescription, icon: UIImage(systemName: "xmark.circle.fill")))
                        return
                    }
                })
                print("Successfully saved user info to Firestore")   
                Drops.show(Drop(title: "Welcome to the Pazarama", subtitle: "You have successfully created your acount", icon: UIImage(systemName: "figure.wave")))
            }
        }
        
    }
        
        @objc func handleShowLogin() {
            let controller = LoginViewController()
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true, completion: nil)        
        }
        
}

    

    



