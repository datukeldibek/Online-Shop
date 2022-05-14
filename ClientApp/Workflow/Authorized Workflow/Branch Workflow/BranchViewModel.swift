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

class BranchViewModel: NSObject, BranchViewModelType {
    var authService: AuthServiceType
    var webApi: WebApiServiceType
    
    init(webApi: WebApiServiceType, authService: AuthServiceType) {
        self.webApi = webApi
        self.authService = authService
    }
    
    func getBranches(completion: @escaping (Result<[BranchDTO], Error>) -> Void) {
        webApi.getBranches(completion: completion)
    }
}
