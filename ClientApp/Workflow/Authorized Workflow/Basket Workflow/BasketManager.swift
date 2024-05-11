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
    func addNewDish(_ dish: ListOrderDetailsDto)
    func getDishes() async throws -> [ListOrderDetailsDto]
}

class BasketManager: BasketManagerType {
    
    private var dishesInCart: [ListOrderDetailsDto] = []
    
    func addNewDish(_ dish: ListOrderDetailsDto) {
        if let dishIndex = dishesInCart.firstIndex(where: { $0.stockId == dish.stockId }) {
            dishesInCart[dishIndex].quantity += 1
        } else {
            var dish = dish
            dish.quantity = 1
            dishesInCart.append(dish)
        }
        
    }
    
    func getDishes() -> [ListOrderDetailsDto] {
        return dishesInCart
    }
    
    func clear() {
        dishesInCart.removeAll()
    }
}

