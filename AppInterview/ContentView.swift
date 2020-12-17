//
//  ContentView.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//

import SwiftUI

struct ContentView: View {
    @State var search = ""
    var body: some View {
        VStack {
            SearchBar(text: self.$search, placeholder: "Search...")
            RowProduct()
            Spacer()
        }
        .onTapGesture {
            endEditing()
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
