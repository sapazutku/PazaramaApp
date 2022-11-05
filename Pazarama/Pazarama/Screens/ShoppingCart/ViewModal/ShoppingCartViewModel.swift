//
//  ShoppingCartViewModel.swift
//  Pazarama
//
//  Created by utku on 2.11.2022.
//

import Foundation

class ShoppingCartViewModel{
    // MARK: - Properties
    var shoppingCart: [ProductItem] = [] {
        didSet {
            self.shoppingCartChanged?()
        }
    }

    var shoppingCartChanged: (() -> Void)?
    
    
    // MARK: - Methods
    
    // get all products from core data
    func getAllProducts() {
        shoppingCart = Product.getAllProducts()
        print("Shopping Cart: \(shoppingCart)")
        
    }
    
    
    func calculateTotalPrice() -> Double {
        var totalPrice = 0
        for item in shoppingCart {
            totalPrice += Int(item.price * Double(item.quantity))
        }
        return Double(totalPrice)
    }




    
}
