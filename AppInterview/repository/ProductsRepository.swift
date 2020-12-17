//
//  ProductsRepository.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//

import Foundation
import Combine
import RealmSwift


protocol IProductQuery {
    func getProducts(query: String) -> Future<ProductsResponse, Never>
}

protocol IApiClient: IProductQuery {}

protocol IProductRepository: IProductQuery {}
protocol IDbRepository {
    func getProducts(query: String) -> Future<[ProductItem], Never>
    func insertProducts(list: [ProductItem])-> Future<Bool, Never>
}

class ProductRepository: IProductRepository {
    
    func getProducts(query: String) -> Future<ProductsResponse, Never>  {
        return client.getProducts(query: query)
    }
    
    var client: IApiClient
    init(client: IApiClient = ApiClient()) {
        self.client = client
    }
    
}

class DbRepository: IDbRepository {
    
    let realm = try! Realm()
    func getProducts(query: String)-> Future<[ProductItem], Never> {
        return Future<[ProductItem], Never> { promise in
            var queryRealm: LazyMapSequence<Results<ProductDb>, ProductItem>? = nil
            var array:[ProductItem] = []
            if query.isEmpty {
                queryRealm = self.realm.objects(ProductDb.self)
                    .map{$0.toClass()}
               
            }
            else {
                let predicate = NSPredicate(format: "search BEGINSWITH %@", query)
                let containsResults = self.realm.objects(ProductDb.self)
                    .filter(predicate)
                    .map{$0.toClass()}
                queryRealm = containsResults
            }
            
          
            for i in 0..<((queryRealm?.count ?? 0) > 20 ? 20 : (queryRealm?.count ?? 0)) {
                if let row = queryRealm?[i] {
                    array.append(row)
                }
            }
            
            promise(.success(array))
        }
    }
    
    func insertProducts(list: [ProductItem])-> Future<Bool, Never>{
        return Future { promise in
            for i in list {
                let objectsToDelete = self.realm.objects(ProductDb.self).filter("id == %@", i.id)
  
                let product = ProductDb()
                product.id = i.id
                product.title = i.title
                product.image = i.image
                product.price = i.price
                product.rating = i.rating ?? 0
                product.search = i.title.lowercased()
                
                try! self.realm.write {
                    self.realm.delete(objectsToDelete)
                    self.realm.add(product)
                }
                
            }
            promise(.success(true))
            
        }
        
    }
}


class ApiClient: IApiClient {
    func getProducts(query: String) -> Future<ProductsResponse, Never> {
        
        return Future { promise in
            
            URLSession.shared.dataTask(with: getRequest(query: query), completionHandler: { data, response, error in
                if let data = data {
                    do {
                        let response = try JSONDecoder().decode(ProductsResponse.self, from: data)
                        
                        promise(.success(response))
                    } catch {
                        promise(.success(ProductsResponse(totalResults: 0, page: 0, items: [])))
                    }
                } else {
                    promise(.success(ProductsResponse(totalResults: 0, page: 0, items: [])))
                }
            }).resume()
            
            
        }
    }
    
}
