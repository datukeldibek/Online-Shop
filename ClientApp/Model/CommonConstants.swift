//
//  CommonConstants.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 4/11/21.
//

import Foundation

enum CommonConstants {
    
    // MARK: - Base
    static let baseUrl = URL(string: "https://neocafe.herokuapp.com")!
    
    // MARK: - Registration
    enum Registration {
        static func registerUser() -> URL {
            baseUrl.appendingPathComponent("client/registration")
        }
        static func confirmCode() -> URL {
            baseUrl.appendingPathComponent("/client/activate")
        }
    }
    
    // MARK: - Authorization
    enum Authorization {
        static func authorizeUser() -> URL {
            baseUrl.appendingPathComponent("/client/auth")
        }
        static func confirmAuthorizationCode() -> URL {
            baseUrl.appendingPathComponent("/client/login")
        }
    }
    
    // MARK: - Profile Editing
    enum ProfileEditing {
        static func setBirthdayToUser() -> URL {
            baseUrl.appendingPathComponent("/client/add-bDate")
        }
    }
}
