//
//  Utils.swift
//  AppInterview
//
//  Created by Jiren on 16/12/20.
//

import Foundation
import UIKit


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
