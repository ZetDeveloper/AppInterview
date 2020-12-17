//
//  ProductsInteractor.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//

import Foundation
import Combine
import SwiftUI
import CoreData

class ProductsInteractor: ObservableObject {
    @Published var search = "" {
        willSet {
            self.getProduct(query: search)
        }
    }
    @Published var list:[ProductItem] = []
    var cancellables = Set<AnyCancellable>()
    let repo = ProductRepository()
    
    func saveProducts(list: [ProductItem]) {
        DbRepository()
            .insertProducts(list: list)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
            debugPrint(completion)
        }, receiveValue: { value in
            debugPrint(value)
            
        }).store(in: &cancellables)
    }
    
    func getData(query: String) {
        DbRepository()
            .getProducts(query: query)
            .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
            debugPrint(completion)
        }, receiveValue: { value in
            
            self.list = value
        }).store(in: &cancellables)
    }
    
    func getProduct(query: String) {
        self.getData(query: self.search)
        repo.getProducts(query: query)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                debugPrint(completion)
            }, receiveValue: { value in
                
                self.saveProducts(list: value.items)
                
            }).store(in: &cancellables)
        
    }
}
