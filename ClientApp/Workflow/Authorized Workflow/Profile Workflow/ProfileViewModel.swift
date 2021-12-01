//
//  ProfileViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import Foundation

protocol ProfileViewModelType {
    func logOut()
    func getUserInfo(completion: @escaping (Result<UserProfileDTO, Error>) -> Void)
    func editProfile(name: String, birthDate: String, completion: @escaping(Result<Void, Error>) -> Void)
    
    // MARK: - Bonuses
    func getBonuses(completion: @escaping(Result<Int, Error>) -> Void)
    func addSubstractBonuses(amount: Int, completion: @escaping (Result<Int, Error>) -> Void)
    
    // MARK: - Get orders history
    func getCurrentOrders(completion: @escaping (Result<[HistoryDTO], Error>) -> Void)
    func getCompletedOrders(completion: @escaping (Result<[HistoryDTO], Error>) -> Void)
}

class ProfileViewModel: ProfileViewModelType {
    
    let authService: AuthServiceType = AuthService.shared
    let webApi: WebApiServiceType = WebApiService.shared
    
    func logOut() {
        authService.logout()
    }
    
    func getUserInfo(completion: @escaping (Result<UserProfileDTO, Error>) -> Void) {
        webApi.getUserInfo(completion: completion)
    }
    
    func editProfile(name: String, birthDate: String, completion: @escaping(Result<Void, Error>) -> Void) {
        webApi.editProfile(name: name, birthDate: birthDate, completion: completion)
    }
    
    func getBonuses(completion: @escaping(Result<Int, Error>) -> Void) {
        webApi.getBonuses(completion: completion)
    }
    
    func addSubstractBonuses(amount: Int, completion: @escaping (Result<Int, Error>) -> Void) {
        webApi.addSubstractBonuses(amount: amount, completion: completion)
    }
    
    func getCurrentOrders(completion: @escaping (Result<[HistoryDTO], Error>) -> Void) {
        webApi.getCurrentOrders(completion: completion)
    }
    
    func getCompletedOrders(completion: @escaping (Result<[HistoryDTO], Error>) -> Void) {
        webApi.getCompletedOrders(completion: completion)
    }
}
