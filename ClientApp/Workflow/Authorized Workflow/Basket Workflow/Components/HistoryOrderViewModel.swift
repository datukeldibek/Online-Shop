//
//  HistoryOrderViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 2/12/21.
//

import Foundation

protocol HistoryOrderViewModelType {
    // MARK: - Get orders history
    func getCurrentOrders(completion: @escaping (Result<[HistoryDTO], Error>) -> Void)
    func getCompletedOrders(completion: @escaping (Result<[HistoryDTO], Error>) -> Void)
    
    func getUserInfo(completion: @escaping (Result<UserProfileDTO, Error>) -> Void)
}

class HistoryOrderViewModel: HistoryOrderViewModelType {
    
    let authService: AuthServiceType = AuthService.shared
    let webApi: WebApiServiceType = WebApiService.shared
    
    func getCurrentOrders(completion: @escaping (Result<[HistoryDTO], Error>) -> Void) {
        webApi.getCurrentOrders(completion: completion)
    }
    
    func getCompletedOrders(completion: @escaping (Result<[HistoryDTO], Error>) -> Void) {
        webApi.getCompletedOrders(completion: completion)
    }
    
    func getUserInfo(completion: @escaping (Result<UserProfileDTO, Error>) -> Void) {
        webApi.getUserInfo(completion: completion)
    }
}
