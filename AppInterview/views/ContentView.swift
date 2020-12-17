//
//  ContentView.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//

import SwiftUI
import Combine
import UIKit

struct ContentView: View {

    @ObservedObject var interactor = ProductsInteractor()
    
    var body: some View {
        VStack {
            SearchBar(text: self.$interactor.search, placeholder: "Search...")
            ScrollView {
                ForEach(self.interactor.list, id: \.id) { product in
                    RowProduct(name: product.title,
                               price: product.price.toMoney(),
                               url: product.image,
                               rating: (product.rating ?? 0.0).toR())
                }
            }  
            Spacer()
        }
        .onTapGesture {
            endEditing()
        }
        .onAppear{
            interactor.getProduct(query: "")
        }
       
    }
    
    private func endEditing() {
            UIApplication.shared.endEditing()
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
