//
//  BasketViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import Foundation

protocol BasketViewModelType {
    func getUserInfo(completion: @escaping (Result<UserProfileDTO, Error>) -> Void)
}

class BasketViewModel: BasketViewModelType {
 
    private let webApi: WebApiServiceType = WebApiService.shared
    
    func getUserInfo(completion: @escaping (Result<UserProfileDTO, Error>) -> Void) {
        webApi.getUserInfo(completion: completion)
    }
}
