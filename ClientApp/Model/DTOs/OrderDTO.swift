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
//    let address: AddressInfoDTO?
}

struct ListOrderDetails: Codable {
    let generalAdditionalId: [Int]
    let quantity: Int
    let stockId: Int
}

struct OrderDTO2: Codable {
    let orderType: String
    let branchId: Int
    let listOrderDetailsDto: [ListOrderDetailsDTO]?
    var address: AddressInfoDTO? = nil
}

struct ListOrderDetailsDTO: Codable, Equatable, Hashable {
    let stockId: Int
    var quantity: Int
}

//{\"branchId\":0,\
//    "orderType\":\"OUT\",\
//    "listOrderDetailsDto\":
//    [{\"stockId\":3,\"price\":200,\"quantity\":3,\"name\":\"Матовая помада (Рубиново-красный)\",\"urlImage\":\"http:\/\/res.cloudinary.com\/dqanzqc0k\/image\/upload\/v1715847896\/ay5mr71mqfwkmprea1lv.jpg\"},
//        {\"price\":100,\"name\":\"test\",\"quantity\":1,\"stockId\":5,\"urlImage\":\"http:\/\/res.cloudinary.com\/dqanzqc0k\/image\/upload\/v1715960923\/dtqkujok2zpazhwsvhox.jpg\"}
//            ],\"address\":{\"numberOfHouse\":\"3\",\"numberOfApartment\":\"5\",\"street\":\"2\",\"numberOFentrance\":\"4\",\"comment\":\"6\",\"city\":\"1\"}}"
//    
//{
//  "orderType": "IN",
//  "branchId": 0,
//  "listOrderDetailsDto": [
//    {
//      "menuId": 0,
//      "quantity": 0
//    }
//  ],
//  "address": {
//    "city": "string",
//    "street": "string",
//    "numberOfHouse": "string",
//    "numberOFentrance": "string",
//    "numberOfApartment": "string",
//    "comment": "string"
//  }
//}
struct AddressInfoDTO: Codable {
    let city: String
    let street: String
    let numberOfHouse: String
    let numberOFentrance: String?
    let numberOfApartment: String?
    let comment: String?
}
