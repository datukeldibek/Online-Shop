//
//  BranchDTO.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 23/11/21.
//

import Foundation

struct BranchDTO: Codable {
    
    let branchId: Int
    let name: String
    let address: String
    let phoneNumber: String
    let link2gis: String?
    let workingTime: String
    
    static func createDefault(id: Int) -> BranchDTO {
        return BranchDTO(branchId: id, name: "name1", address: "bishkek", phoneNumber: "111111111", link2gis: "", workingTime: "12-19")
    }
}
