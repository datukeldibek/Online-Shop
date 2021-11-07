//
//  JWT.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 4/11/21.
//

import Foundation


struct JwtInfo: Codable {
    let jwt: String
    let expDate: String
    
    var jwtTokenExpired: Bool {
        return expDate.toDate() > Date()
    }
}

extension String {
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date!
    }
}



