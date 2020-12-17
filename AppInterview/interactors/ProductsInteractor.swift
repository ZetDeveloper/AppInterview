//
//  ProductsInteractor.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//

import Foundation
import Combine
import SwiftUI

class ProductsInteractor: ObservableObject {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Published var list:[ProductItem] = []
    var cancellables = Set<AnyCancellable>()
    let repo = ProductRepository()
    
    func saveProducts(list: [ProductItem]) {
        DbRepository().insertProducts(context: managedObjectContext, list: list)
    }
    
    func getProduct(query: String){
        repo.getProducts(query: query)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                debugPrint(completion)
            }, receiveValue: { value in
                
                self.saveProducts(list: value.items)
                
                self.list = value.items
            }).store(in: &cancellables)
        
    }
}
