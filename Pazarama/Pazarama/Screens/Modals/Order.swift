//
//  Order.swift
//  Pazarama
//
//  Created by utku on 31.10.2022.
//

import Foundation

struct Order {
    var items: [String]
    var price: Int
    init(items: [String], price: Int) {
        self.items = items
        self.price = price
    }
}
