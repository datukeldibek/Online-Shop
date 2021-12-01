//
//  UserProfileInfoDTO.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 1/12/21.
//

import Foundation

struct UserProfileDTO: Codable {
    let bdate: String
    let id: Int
    let name: String
    let phoneNumber: String
    
    var formattedDate: Date {
        bdate.toDate()
    }
}
