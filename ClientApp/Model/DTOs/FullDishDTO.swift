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
    let price: Int
    let count: Int?
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
