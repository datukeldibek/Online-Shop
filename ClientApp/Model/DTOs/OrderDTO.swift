//
//  OrderDTO.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 28/11/21.
//

import Foundation

struct OrderDTO: Codable {
    let branchId: Int
    let listOrderDetailsDto: [ListOrderDetailsDto]?
    let orderType: String
}

struct ListOrderDetails: Codable {
    let generalAdditionalId: [Int]
    let quantity: Int
    let stockId: Int
}
struct OrderDetailDTO: Codable {
    let menuId: Int
    let quantity: Int
}

struct AddressInfoDTO: Codable {
    let city: String
    let street: String
    let numberOfHouse: String
    let numberOFentrance: String
    let numberOfApartment: String
    let comment: String
}

struct OrderDTO2: Codable {
    let orderType: String
    let branchId: Int
    let listOrderDetailsDto: [OrderDetailDTO]
    let address: AddressInfoDTO
}
