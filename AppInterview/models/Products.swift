//
//  Products.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//

import Foundation
import RealmSwift

// MARK: - ProductsResponse
struct ProductsResponse: Codable {
    let totalResults, page: Int
    let items: [ProductItem]
}

// MARK: - Item
struct ProductItem: Codable {
    let id: String
    let rating: Double?
    let price: Double
    let image: String
    let title: String
}

final class ProductDb: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var rating: Double = 0
    @objc dynamic var price: Double = 0
    @objc dynamic var image: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var search: String = ""

    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toClass()-> ProductItem {
        return ProductItem(id: self.id,
                           rating: self.rating,
                           price: self.price,
                           image: self.image,
                           title: self.title)
    }
}
