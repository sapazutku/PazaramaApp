//
//  ProfileViewModal.swift
//  Pazarama
//
//  Created by utku on 1.11.2022.
//


import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class ProfileViewModal{
    let settingsArray = ["Upload Profile Photo", "Change Username", "Change Email", "Change Password", "About App"]

    // user info
    var user: User?
    
    let database = Firestore.firestore()

    // MARK: - Database Methods

    func updateUsername(username:String){
        database.collection("users").document(Auth.auth().currentUser!.uid).updateData(["username": username]) { error in
            if error != nil {
                print("Error")
            } else {
                print("Success")
                
            }
        }
    }

    func getUsername() -> String{
        var username = ""
        database.collection("users").document(Auth.auth().currentUser!.uid).getDocument { document, error in
            if let document = document, document.exists {
                username = document.get("username") as! String
            } else {
                print("Document does not exist")
            }
        }
        return username
    }

    func updateEmail(email:String){
        database.collection("users").document(Auth.auth().currentUser!.uid).updateData(["email": email]) { error in
                if error != nil {
                    print("Error")
                } else {
                    print("Success")
                }
            }
    }

    func getEmail() -> String{
        var email = ""
        database.collection("users").document(Auth.auth().currentUser!.uid).getDocument { document, error in
            if let document = document, document.exists {
                email = document.get("email") as! String
            } else {
                print("Document does not exist")
            }
        }
        return email
    }

    func updatePassword(password:String){
        database.collection("users").document(Auth.auth().currentUser!.uid).updateData(["password": password]) { error in
            if error != nil {
                print("Error")
            } else {
                print("Success")
            }
        }
    }
    
}
