//
//  Product+Extension.swift
//  Pazarama
//
//  Created by utku on 27.10.2022.
//

import Foundation
import UIKit
import CoreData


extension Product {
    // get all products
    static func getAllProducts() -> [ProductItem] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductItem")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(fetchRequest)
            return result as! [ProductItem]
        } catch {
            print("Failed")
            return []
        }
    }

    // add product to core data
    static func addProduct(product: Product) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ProductItem", in: context)
        // control product is exist or not
        for item in getAllProducts() {
            if item.title == product.title {
                item.quantity += 1
                return
            }
        }
        let newProduct = NSManagedObject(entity: entity!, insertInto: context)
        newProduct.setValue(product.title, forKey: "title")
        newProduct.setValue(product.price, forKey: "price")
        newProduct.setValue(1, forKey: "quantity")
    }

    // delete product from core data

    
}

/*
for item in products {
            if item.title == product.title {
                product.quantity += 1
                return
            }
        }


if let productItem = Product.getAllProducts().first(where: { $0.title == product.title }) {
            productItem.quantity += 1
        } else {
            newProduct.setValue(product.title, forKey: "title")
            newProduct.setValue(product.price, forKey: "price")
            newProduct.setValue(1, forKey: "quantity")
            do {
                try context.save()
            } catch {
                print("Failed")
            }
        }
*/

