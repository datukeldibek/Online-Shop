//
//  CategoryDTO.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 28/11/21.
//

import Foundation

struct FullCategoryDTO: Codable, Hashable {
    static func == (lhs: FullCategoryDTO, rhs: FullCategoryDTO) -> Bool {
        lhs.id == rhs.id
    }
    
    let category: CategoryDTO
    let description: String
    let id: Int
    let imagesUrl: URL
    let name: String
    let price: Int
    let status: String
}

struct CategoryDTO: Codable, Hashable {
    static func == (lhs: CategoryDTO, rhs: CategoryDTO) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let name: String
    let status: String
}

struct CategoryMenuDTO: Codable {
    let name: String
    let price: Double
}
