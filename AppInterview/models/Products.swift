//
//  Products.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//

import Foundation

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

