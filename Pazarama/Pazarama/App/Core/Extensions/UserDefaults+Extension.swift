//
//  UserDefaults+Extension.swift
//  Pazarama
//
//  Created by utku on 27.10.2022.
//

import Foundation

extension UserDefaults {
    func getProducts() -> [Product] {
        guard let data = data(forKey: "products") else { return [] }
        let decoder = JSONDecoder()
        guard let products = try? decoder.decode([Product].self, from: data) else { return [] }
        return products
    }
    
    func setProducts(products: [Product]) {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(products) else { return }
        set(data, forKey: "products")
    }
    
    func addProduct(product: Product) {
        var products = getProducts()
        products.append(product)
        setProducts(products: products)
    }
    
    func deleteProduct(product: Product) {
        var products = getProducts()
        products.removeAll { $0.id == product.id }
        setProducts(products: products)
    }
    
    func isProductExist(product: Product) -> Bool {
        var products = getProducts()
        return products.contains { $0.id == product.id }
    }
}