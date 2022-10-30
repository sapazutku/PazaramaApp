//
//  ProfileViewController.swift
//  Pazarama
//
//  Created by utku on 25.10.2022.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import SnapKit
//import FirebaseStorage
class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsArray.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! UITableViewCell
        cell.selectionStyle = .gray
        cell.backgroundColor = .systemBackground
        cell.textLabel?.text = settingsArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }

    // MARK: - Properties

    private let settingsArray = ["Change Profile Photo", "Change Username", "Change E-mail", "Change Password", "My Orders", "About App"]

    // user info
    var user: User?


     private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.text = "utku"
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.text = "utku.sapaz@gmail.com"
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()

    private let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemPink
        return iv
    }()

    // settings
    private let settingsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        
        tableView.separatorStyle = .singleLine
        return tableView
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        getUser()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUser()
    }


    // MARK: - Helpers

    func configureUI(){
        // navigation item title
        navigationItem.title = "Profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain , target: self, action: #selector(handleLogout))        // view background color
        view.backgroundColor = .white
        // user info
        view.addSubview(profileImageView)
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.equalTo(view.snp.left).offset(20)
            make.width.height.equalTo(100)
        }
        profileImageView.layer.cornerRadius = 100 / 2
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.left.equalTo(profileImageView.snp.right).offset(20)
        }
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.left.equalTo(usernameLabel.snp.left)
        }

        // settings
        view.addSubview(settingsTableView)
        
        settingsTableView.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(view.snp.bottom)
        }
        // make cell center
        
        settingsTableView.delegate = self
        settingsTableView.dataSource = self
        settingsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "settingCell")
        
    }

    // MARK: - Methods

    func getUserPhoto(uid:String){
        // get profile image from firebase storage
       print("a")
    }

    public func getUser(){   
        // get user info from Firestore
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to fetch user with error \(error.localizedDescription)")
                return
            }
            guard let dictionary = snapshot?.data() else { return }
            self.user = User(username: dictionary["username"] as! String, email: dictionary["email"] as! String, orders: dictionary["orders"] as! [String], uid: uid)
            self.usernameLabel.text = self.user?.username
            self.emailLabel.text = self.user?.email
            
            self.getUserPhoto(uid: uid)
            self.tableView.reloadData()
            
        }
    }

    @objc func handleLogout(){
       print("DEBUG: handle logout")
    }


        
}

