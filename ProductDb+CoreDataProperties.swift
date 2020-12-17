//
//  ProductDb+CoreDataProperties.swift
//  AppInterview
//
//  Created by Jiren on 17/12/20.
//
//

import Foundation
import CoreData


extension ProductDb {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductDb> {
        return NSFetchRequest<ProductDb>(entityName: "ProductDb")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var rating: String?
    @NSManaged public var price: Double

}

extension ProductDb : Identifiable {

}
