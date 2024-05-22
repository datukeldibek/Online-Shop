//
//  HistoryDTO.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 1/12/21.
//

import Foundation

struct HistoryDTO: Codable {
    let branchAddress: String
    let branchId: Int
    let branchLink2gis: String
    let branchName: String
    let branchPhoneNumber: String
    let branchWorkingTime: String
    let listOrderDetailsDto: [ListOrderDetailsDto]
    let orderId: Int
    let orderTime: String
    let orderType: String
    let status: String
    let tableId: Int
    let totalPrice: Int
}

struct ListOrderDetailsDto: Codable, Equatable, Hashable {
    static func == (lhs: ListOrderDetailsDto, rhs: ListOrderDetailsDto) -> Bool {
        lhs.stockId == rhs.stockId && lhs.name == rhs.name
    }
    
    let stockId: Int
    let urlImage: String?
    let generalAdditionalId: [GeneralAddition]?
    let name: String
    let price: Int
    var quantity: Int
    var caltTotal: Int?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(stockId)
    }
}

struct GeneralAddition: Codable {
    let generalAdditionalId: Int
}

// MARK: - FullCategoryDTOElement
struct FullCategoryDTOElement: Codable {
    let id: Int
    let orderDate, branchName, orderType: String
    let totalPrice: Int
    let orderStatus: String
    let orderDetails: [OrderDetail]
    let addressDto: AddressDto
}

// MARK: - AddressDto
struct AddressDto: Codable {
    let city, street, numberOfHouse, numberOFentrance: String
    let numberOfApartment, comment: String
}

// MARK: - OrderDetail
struct OrderDetail: Codable {
    let id, quantity, calcTotal: Int
    let name, description, imagesURL, categoryName: String
    let price: Int

    enum CodingKeys: String, CodingKey {
        case id, quantity, calcTotal, name, description
        case imagesURL = "imagesUrl"
        case categoryName, price
    }
}
