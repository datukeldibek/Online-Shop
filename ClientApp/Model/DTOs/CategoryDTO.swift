//
//  CategoryDTO.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 28/11/21.
//

import Foundation

struct FullCategoryDTO: Codable, Hashable {
    
    var uuid = UUID()
    
    private enum CodingKeys : String, CodingKey {
        case category, description, id, imagesUrl, name, price, status
    }
    
    static func == (lhs: FullCategoryDTO, rhs: FullCategoryDTO) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
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
    
//    var uuid = UUID()
    
    private enum CodingKeys : String, CodingKey { case id, name, status }
 
    static func == (lhs: CategoryDTO, rhs: CategoryDTO) -> Bool {
        lhs.id == rhs.id
    }
    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(uuid)
//    }
    
    let id: Int
    let name: String
    let status: String
}

struct CategoryMenuDTO: Codable {
    
    let name: String
    let price: Double
}
