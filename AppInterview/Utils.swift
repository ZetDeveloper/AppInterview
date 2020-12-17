//
//  Utils.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//

import Foundation
import UIKit

extension Double {
    func toMoney()-> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return "$" + numberFormatter.string(from: self as NSNumber)!
        
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


extension URLRequest {
    
    mutating func addAuth(){
        self.setValue("62e3cee8-a7b4-4579-8f70-08e99d09f27a", forHTTPHeaderField: "X-IBM-Client-Id")
        self.timeoutInterval = 10
        
    }
    
}

func getRequest(query: String) -> URLRequest {
    var url = URLRequest(url: URL(string: "https://00672285.us-south.apigw.appdomain.cloud/demo-gapsi/search?&query=\(query)")!)
    url.addAuth()
    return url
}
