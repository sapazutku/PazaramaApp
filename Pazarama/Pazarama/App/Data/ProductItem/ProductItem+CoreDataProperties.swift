//
//  ProductItem+CoreDataProperties.swift
//  Pazarama
//
//  Created by utku on 28.10.2022.
//
//

import Foundation
import CoreData


extension ProductItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductItem> {
        return NSFetchRequest<ProductItem>(entityName: "ProductItem")
    }

    @NSManaged public var price: Double
    @NSManaged public var title: String?
    @NSManaged public var quantity: Int16

}

extension ProductItem : Identifiable {

}
