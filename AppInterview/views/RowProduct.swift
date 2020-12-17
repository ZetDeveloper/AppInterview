//
//  RowProduct.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//


import SwiftUI

struct RowProduct: View {
    @State var search = ""
    var body: some View {
        HStack {
            VStack(spacing: 0){
                Image("place")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                   
            }
            .frame(width: 100, height: 100)
         
                    HStack {
                        VStack(alignment: .leading) {
                            Text("$ 50.00")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Text("Name Product")
                                .font(.headline)
                                .fontWeight(.black)
                                .foregroundColor(.primary)
                                .lineLimit(2)
                            Text("Rating".uppercased())
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .padding()
                }
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color(.sRGB, red: 150/255, green: 150/255, blue: 150/255, opacity: 0.1), lineWidth: 1)
                )
                .padding([.top, .horizontal])
       
    }
}

struct RowProduct_Previews: PreviewProvider {
    static var previews: some View {
        RowProduct()
    }
}
