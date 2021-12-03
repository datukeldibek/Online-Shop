//
//  CategoryDTO.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 28/11/21.
//

import Foundation

struct FullCategoryDTO: Codable, Hashable {
    
    private enum CodingKeys : String, CodingKey {
        case category, description, id, imagesUrl, name, price, status
    }
    
    let category: CategoryDTO
    let description: String
    let id: Int
    let imagesUrl: URL?
    let name: String
    let price: Int
    let status: String
}

struct CategoryDTO: Codable, Hashable {
    private enum CodingKeys : String, CodingKey { case id, name, status }
    
    let id: Int
    let name: String
    let status: String
}

struct CategoryMenuDTO: Codable {
    let name: String
    let price: Double
}
