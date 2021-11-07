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
    
    private let keyValueStore: KeyValueStoreType = TransientStorageService.shared
    private let authService: AuthServiceType = AuthService.shared
    
    var isAuthorized: Bool {
        return authService.isAuthorized
    }
    
    var userLoggedIn: Bool {
        keyValueStore.bool(forKey: .userLoggedIn)
    }
    
    func logout() {
        authService.logout()
    }
}
