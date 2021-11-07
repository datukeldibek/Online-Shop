//
//  PhoneRegistrationViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 4/11/21.
//

import Foundation

protocol PhoneRegistrationViewModelType {
    func registerNewUser(user: RegistrationDTO, completion: @escaping (Result<Void, Error>) -> Void)
    func sendConfirmation(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<Void, Error>) -> Void)
    
    func setBirthdayToUser(userBDay: BirthdayDTO, completion: @escaping (Result<BirthdayDTO, Error>) -> Void)
}

class PhoneRegistrationViewModel: PhoneRegistrationViewModelType {
    
    private let authService: AuthServiceType = AuthService.shared
    
    func registerNewUser(user: RegistrationDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        authService.registerViaPhone(user: user, completion: completion)
    }
    
    func sendConfirmation(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        authService.sendConfirmation(for: phoneNumber, confirmationCode: confirmationCode, completion: completion)
    }
    
    func setBirthdayToUser(userBDay: BirthdayDTO, completion: @escaping (Result<BirthdayDTO, Error>) -> Void) {
        
    }
}
