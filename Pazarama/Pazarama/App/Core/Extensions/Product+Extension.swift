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
        let newProduct = NSManagedObject(entity: entity!, insertInto: context)
        newProduct.setValue(product.title, forKey: "title")
        newProduct.setValue(product.price, forKey: "price")
        newProduct.setValue(product.image, forKey: "image")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }

    // delete product from core data

    
}
