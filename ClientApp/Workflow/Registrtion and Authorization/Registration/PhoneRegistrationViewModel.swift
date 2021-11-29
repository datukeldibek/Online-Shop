//
//  PhoneRegistrationViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 4/11/21.
//

import Foundation

protocol PhoneRegistrationViewModelType {
    var userLoggedIn: Bool { get }
    var isAuthorized: Bool { get }
    
    func registerNewUser(user: RegistrationDTO, completion: @escaping (Result<Void, Error>) -> Void)
    func sendConfirmation(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<JwtInfo, Error>) -> Void)
    
    func setBirthdayToUser(userBDay: BirthdayDTO, completion: @escaping (Result<BirthdayDTO, Error>) -> Void)
}

class PhoneRegistrationViewModel: PhoneRegistrationViewModelType {
    
    private let authService: AuthServiceType = AuthService.shared
    private let keyValueStore: KeyValueStoreType = TransientStorageService.shared
    private let webApi: WebApiServiceType = WebApiService.shared

    var isAuthorized: Bool {
        return authService.isAuthorized
    }
    
    var userLoggedIn: Bool {
        keyValueStore.bool(forKey: .userLoggedIn)
    }
    
    func registerNewUser(user: RegistrationDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        authService.registerViaPhone(user: user, completion: completion)
    }
    
    func sendConfirmation(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<JwtInfo, Error>) -> Void) {
        authService.sendConfirmation(for: phoneNumber, confirmationCode: confirmationCode, completion: completion)
    }
    
    func setBirthdayToUser(userBDay: BirthdayDTO, completion: @escaping (Result<BirthdayDTO, Error>) -> Void) {
        webApi.setBirthdayToUser(userBDay: userBDay, completion: completion)
    }
}
