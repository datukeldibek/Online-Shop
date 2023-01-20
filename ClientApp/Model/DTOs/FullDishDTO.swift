//
//  FullDishDTO.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 28/11/21.
//

import Foundation

struct DishDTO: Codable {
    let description: String
    let generalAdditionals: [GeneralAdditionals]?
    let id: Int
    let imageUrl: URL?
    let name: String
    let price: Double
    var count: Int?
}

extension DishDTO: OrderType {
    var dishId: Int { id }
    var dishName: String { name }
    var dishPrice: Double { price }
    var sum: Double? { Double(count ?? 0) * price }
    var dishUrl: URL? { imageUrl }
    var quanitity: Int? {
        get { count }
        set { _ = count }
    }
}

struct GeneralAdditionals: Codable {
    let id: Int
    let nameProduct: String
    let price: Int
    let typeGeneralAdditional: String
}

struct FullDishDTO: Codable {
    let branch: BranchDTO
    let order: OrderDTO
    let totalPrice: Int
}
