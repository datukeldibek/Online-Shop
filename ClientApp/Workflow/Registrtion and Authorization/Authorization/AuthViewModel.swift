//
//  AuthViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 3/11/21.
//

import Foundation

protocol AuthViewModelType {
    func authorizeUser(user: AuthorizationDTO, completion: @escaping (Result<Void, Error>) -> Void)
    func confirmAuthCode(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<JwtInfo, Error>) -> Void)
}

class AuthViewModel: AuthViewModelType {
    private let authService: AuthServiceType
    
    init(authService: AuthServiceType) {
        self.authService = authService
    }
    
    func authorizeUser(user: AuthorizationDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        authService.authorizeUser(user: user, completion: completion)
    }
     
    func confirmAuthCode(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<JwtInfo, Error>) -> Void) {
        authService.confirmAuthCode(for: phoneNumber, confirmationCode: confirmationCode, completion: completion)
    }
}
