//
//  BranchViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import Foundation

protocol BranchViewModelType {
    func getBranches(completion: @escaping (Result<[BranchDTO], Error>) -> Void)
}

class BranchViewModel: BranchViewModelType {
    
    let authService: AuthServiceType = AuthService.shared
    let webApi: WebApiServiceType = WebApiService.shared
    
    func getBranches(completion: @escaping (Result<[BranchDTO], Error>) -> Void) {
        webApi.getBranches(completion: completion)
    }
}
