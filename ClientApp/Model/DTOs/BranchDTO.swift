//
//  BranchDTO.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 23/11/21.
//

import Foundation

struct BranchDTO: Codable {
    let address: String
    let id: Int
    let link2gis: String?
    let name: String
    let phoneNumber: String
    let status: String
}
