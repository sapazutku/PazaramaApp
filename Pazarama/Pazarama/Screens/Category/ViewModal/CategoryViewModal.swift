//
//  CategoryViewModal.swift
//  Pazarama
//
//  Created by utku on 1.11.2022.
//

import UIKit

class CategoryViewModal{
    
    // MARK: - Properties

    var filteredArray = [CategoryModal]()

    let categoryList: [CategoryModal] = [
        CategoryModal(name: "electronics", image: "electronics"),
        CategoryModal(name: "jewelery", image: "jewelery"),
        CategoryModal(name: "women's clothing", image: "womens"),
        CategoryModal(name: "men's clothing", image: "mens"),
    ]
}
