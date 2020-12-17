//
//  ProductsRepository.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//

import Foundation
import Combine
import CoreData


protocol IProductQuery {
    func getProducts(query: String) -> Future<ProductsResponse, Never>
}

protocol IApiClient: IProductQuery {}

protocol IProductRepository : IProductQuery {}

class ProductRepository: IProductRepository {
    
    func getProducts(query: String) -> Future<ProductsResponse, Never>  {
        return client.getProducts(query: query)
    }
    
    var client: IApiClient
    init(client: IApiClient = ApiClient()) {
        self.client = client
    }
    
}

class DbRepository {
    func insertProducts(context: NSManagedObjectContext, list: [ProductItem])-> Future<Bool, Never>{
        return Future { promise in
            for i in list {
                guard let entity = NSEntityDescription.entity(forEntityName: "ProductDb", in: context) else { return  }
                
                let record = NSManagedObject(entity: entity, insertInto: context)
                
                record.setValue(i.rating, forKey: "rating")
                record.setValue(i.image, forKey: "url")
                record.setValue(i.id, forKey: "id")
                record.setValue(i.title, forKey: "name")
                do {
                    try context.save()
                    
                } catch
                    let error as NSError {
                    
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
