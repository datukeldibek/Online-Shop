//
//  Products.swift
//  ClientApp
//
//  Created by Datu on 17/5/24.
//

import Foundation
import SwiftUI

final class Products {
    
    static var all: [ListOrderDetailsDto] = []
}

//final class Products {
//    
//    static var all: [ListOrderDetailsDto] {
//        get {
//            if let data = UserDefaults.standard.data(forKey: "basket") {
//                do {
//                    let decoder = JSONDecoder()
//                    let items = try decoder.decode([ListOrderDetailsDto].self, from: data)
//                    return items
//                } catch {
//                    print("Unable to Decode Note (\(error))")
//                }
//            }
//            return Products.all
//        }
//        set {
//            do {
//                let encoder = JSONEncoder()
//                let data = try encoder.encode(newValue)
//                UserDefaults.standard.set(data, forKey: "basket")
//            } catch {
//                print("Unable to Encode Note (\(error))")
//            }
////            Products.all = newValue
//        }
//    }
//}
