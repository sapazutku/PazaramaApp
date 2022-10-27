//
//  ProductItem+CoreDataProperties.swift
//  Pazarama
//
//  Created by utku on 27.10.2022.
//
//

import Foundation
import CoreData


extension ProductItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductItem> {
        return NSFetchRequest<ProductItem>(entityName: "ProductItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?
    @NSManaged public var price: Double

}

extension ProductItem : Identifiable {

}
