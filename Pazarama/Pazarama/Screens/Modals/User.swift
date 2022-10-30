//
//  User.swift
//  Pazarama
//
//  Created by utku on 30.10.2022.
//
import FirebaseFirestore
import FirebaseAuth
import Foundation


class User {
    var username: String
    var email: String
    
    var orders: [Order]?
    
    
    init(username: String,email: String, orders:[Order]?) {
        self.username = username
        self.email = email
        
        self.orders = orders
        
    }
    
    struct Order {
        var items: [String]
        var price: Int
        init(items: [String], price: Int) {
            self.items = items
            self.price = price
        }
    }

    
}
