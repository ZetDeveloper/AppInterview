//
//  Utils.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//

import Foundation
import UIKit
import RealmSwift

extension Array where Element : Equatable {
  public subscript(safe bounds: Range<Int>) -> ArraySlice<Element> {
    if bounds.lowerBound > count { return [] }
    let lower = Swift.max(0, bounds.lowerBound)
    let upper = Swift.max(0, Swift.min(count, bounds.upperBound))
    return self[lower..<upper]
  }
  
  public subscript(safe lower: Int?, _ upper: Int?) -> ArraySlice<Element> {
    let lower = lower ?? 0
    let upper = upper ?? count
    if lower > upper { return [] }
    return self[safe: lower..<upper]
  }
}

extension Results{

    func get <T:Object> (offset: Int, limit: Int ) -> Array<T>{
        //create variables
        var lim = 0 // how much to take
        var off = 0 // start from
        var l: Array<T> = Array<T>() // results list

        //check indexes
        if off<=offset && offset<self.count - 1 {
            off = offset
        }
        if limit > self.count {
            lim = self.count
        }else{
            lim = limit
        }

        //do slicing
        for i in off..<lim{
            let dog = self[i] as! T
            l.append(dog)
        }

        //results
        return l
    }
}

extension Double {
    func toR()-> String {
        
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter.string(from: self as NSNumber)!
        
    }
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
    var url = URLRequest(url: URL(string: "https://00672285.us-south.apigw.appdomain.cloud/demo-gapsi/search?&query=\(query)"
                                    .addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!)!)
    url.addAuth()
    return url
}
