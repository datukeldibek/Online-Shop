//
//  BasketManager.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 2/12/21.
//

import Foundation

protocol OrderType {
    var dishId: Int { get }
    var dishName: String { get }
    var dishPrice: Double { get }
    var description: String { get }
    var dishUrl: String? { get }
}

protocol BasketManagerType {
    func addToCart(_ dish: ListOrderDetailsDto)
    func getCart() async throws -> [ListOrderDetailsDto]
}

class BasketManager: BasketManagerType {
    static let shared = BasketManager()
    
    private let userDefaults = UserDefaults.standard
    private let cartKey = "basket"
    
    private var cart: [ListOrderDetailsDto] {
        get {
            if let data = userDefaults.data(forKey: cartKey),
               let decodedCart = try? JSONDecoder().decode([ListOrderDetailsDto].self, from: data) {
                return decodedCart
            }
            return []
        }
        set {
            if let encodedCart = try? JSONEncoder().encode(newValue) {
                userDefaults.set(encodedCart, forKey: cartKey)
            }
        }
    }
    
    
    func addToCart(_ product: ListOrderDetailsDto) {
        var currentCart = cart
        if !currentCart.contains(product) {
            currentCart.append(product)
        }else {
            for (index, j) in currentCart.enumerated() {
                if j.stockId == product.stockId {
                    currentCart[index] = product
                }
            }
        }
        cart = currentCart
    }
    
    func removeFromCart(product: ListOrderDetailsDto) {
        var currentCart = cart
        if let index = currentCart.firstIndex(where: { $0.stockId == product.stockId }) {
            currentCart.remove(at: index)
            cart = currentCart
        }
    }
    
    func getCart() -> [ListOrderDetailsDto] {
        return cart
    }
}

