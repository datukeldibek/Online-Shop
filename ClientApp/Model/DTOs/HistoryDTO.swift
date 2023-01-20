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

struct ListOrderDetailsDto: Codable {
    let calcTotal: Int
    let chosenGeneralAdditional: [GeneralAddition]?
    let id: Int
    let name: String
    let price: Int
    let quantity: Int
}

struct GeneralAddition: Codable {
    let generalAdditionalId: Int
    let generalAdditionalName: String
}

