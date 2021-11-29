//
//  ProfileViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import Foundation

protocol ProfileViewModelType {
    func logOut()
    func editProfile(userName: String, birthDate: String, completion: @escaping(Result<Void, Error>) -> Void)
    
    // MARK: - Bonuses
    func getBonuses(completion: @escaping(Result<Int, Error>) -> Void)
    func addSubstractBonuses(amount: Int, completion: @escaping (Result<Int, Error>) -> Void)
    
    // MARK: - Get orders history
    
}

class ProfileViewModel: ProfileViewModelType {
    
    let authService: AuthServiceType = AuthService.shared
    let webApi: WebApiServiceType = WebApiService.shared
    
    func logOut() {
        authService.logout()
    }
    
    func editProfile(userName: String, birthDate: String, completion: @escaping(Result<Void, Error>) -> Void) {
        webApi.editProfile(userName: userName, birthDate: birthDate, completion: completion)
    }
    
    func getBonuses(completion: @escaping(Result<Int, Error>) -> Void) {
        webApi.getBonuses(completion: completion)
    }
    
    func addSubstractBonuses(amount: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        webApi.addSubstractBonuses(amount: amount, completion: completion)
    }
}
