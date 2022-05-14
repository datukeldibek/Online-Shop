//
//  SplashViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 3/11/21.
//

import Foundation

protocol SplashViewModelType {
    var userLoggedIn: Bool { get }
    var isAuthorized: Bool { get }
    func logout()
}

class SplashViewModel: SplashViewModelType {
    
    private let keyChaninService: KeyValueStoreType
    private let authService: AuthServiceType
    
    init(authService: AuthServiceType, keyChaninService: KeyValueStoreType) {
        self.authService = authService
        self.keyChaninService = keyChaninService
    }
    
    var isAuthorized: Bool {
        return authService.isAuthorized
    }
    
    var userLoggedIn: Bool {
        keyChaninService.bool(forKey: .userLoggedIn)
    }
    
    func logout() {
        authService.logout()
    }
}
