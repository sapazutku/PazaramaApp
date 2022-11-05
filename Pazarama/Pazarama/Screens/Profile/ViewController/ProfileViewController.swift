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
import FirebaseStorage
import Drops
class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate{


    // MARK: - Properties

    let profileViewModal = ProfileViewModal()
    private let storage = Storage.storage().reference()
    
    var imagePicker = UIImagePickerController()
    
     private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemPink
        label.font = UIFont.systemFont(ofSize: 15)
        
        return label
    }()

    private let profileImageView: UIImageView = {
        
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
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
        navigationItem.rightBarButtonItem?.tintColor = .systemPink
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain , target: self, action: #selector(handleLogout))
       
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
         Storage.storage().reference().child("images/\(uid).png").getData(maxSize: 15 * 1024 * 1024) { data, error in
             if error != nil  {
                 print("Failed to fetch user photo with error \(error!.localizedDescription)")
                 return
             }
             guard let data = data else { return }
             let image = UIImage(data: data)
             self.profileImageView.image = image
         }
    }

    // get user from Firebase
    public func getUser(){
        // get user info from Firestore
        guard let uid = Auth.auth().currentUser?.uid else { return }
        Firestore.firestore().collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                print("Failed to fetch user with error \(error.localizedDescription)")
                return
            }
            guard let dictionary = snapshot?.data() else { return }
            self.profileViewModal.user = User(username: dictionary["username"] as! String, email: dictionary["email"] as! String, orders: dictionary["orders"] as? [Order])
            self.usernameLabel.text = self.profileViewModal.user?.username
            self.emailLabel.text = self.profileViewModal.user?.email
            self.getUserPhoto(uid: uid)
        }
    }

    @objc func handleLogout(){
        do {
            try Auth.auth().signOut()
            let nav = UINavigationController(rootViewController: LoginViewController())
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    @objc func handleSettings(row: Int) {
        switch row {
        case 0:
            changeProfilePhoto()
        case 1:
            changeUsername()
        case 2:
            changeEmail()
        case 3:
            changePassword()
        case 4:
            about()
        default:
            print("Error")
        }
    }
    
    
    func changeProfilePhoto() {
        let alert = UIAlertController(title: "Change Profile Photo", message: "Choose a photo", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openPhotoLibrary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openPhotoLibrary() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }


    func changeUsername() {
        let alert = UIAlertController(title: "Change Username", message: "Enter a new username", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "New Username"
        }
        alert.addAction(UIAlertAction(title: "Change", style: .default, handler: { _ in
            let username = alert.textFields![0].text
            self.profileViewModal.updateUsername(username: username!)
            // reload username from database
            self.getUser()
            Drops.show(Drop(title: "Username Updated", icon: UIImage(systemName: "person.crop.circle.fill.badge.checkmark")))
            DispatchQueue.main.async {
                self.usernameLabel.text = self.profileViewModal.user?.username
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func changePassword() {
        let alert = UIAlertController(title: "Change Password", message: "Enter a new password", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Password"
        }
        
        alert.addAction(UIAlertAction(title: "Change", style: .default, handler: { _ in
            let password = alert.textFields![0].text
            self.profileViewModal.updatePassword(password: password!)
            Drops.show(Drop(title: "Password Updated", icon: UIImage(systemName: "person.crop.circle.fill.badge.checkmark")))
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func changeEmail(){
        let alert = UIAlertController(title: "Change Email", message: "Enter a new email", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Email"
        }
        
        alert.addAction(UIAlertAction(title: "Change", style: .default, handler: { _ in
            let email = alert.textFields![0].text
            self.profileViewModal.updateEmail(email: email!)
            // reload email from database
            self.getUser()
            Drops.show(Drop(title: "Email Updated", icon: UIImage(systemName: "person.crop.circle.fill.badge.checkmark")))
            DispatchQueue.main.async {
                self.emailLabel.text = self.profileViewModal.user?.email
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }


    func about() {
        let alert = UIAlertController(title: "About", message: "Pazarama App is final project of Pazarama iOS Bootcamp, made by Utku Sapaz.`https://github.com/sapazutku/PazaramaApp`", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        //let imageView = UIImageView(frame: CGRect(x: 60, y: 5, width: 50, height: 50))
        //imageView.image = UIImage(named: "pazarama")
        //alert.view.addSubview(imageView)
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: -Overrides
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileViewModal.settingsArray.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath) as! UITableViewCell
        cell.selectionStyle = .gray
        cell.backgroundColor = .systemBackground
        cell.textLabel?.text = profileViewModal.settingsArray[indexPath.row]
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleSettings(row: indexPath.row)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        guard let imageData = image.pngData() else {
            return
        }

        // get user id
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }

        storage.child("images/\(uid).png").putData(imageData, metadata: nil) { _, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            self.storage.child("images/\(uid).png").downloadURL { url, error in
                guard let url = url, error == nil else {
                    return
                }
                let urlString = url.absoluteString
                print("Download URL: \(urlString)")
                UserDefaults.standard.set(urlString, forKey: "profile_picture_url")
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }
        }

    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
         
}
