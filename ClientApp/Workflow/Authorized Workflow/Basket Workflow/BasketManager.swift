//
//  BasketManager.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 2/12/21.
//

import Foundation

protocol BasketManagerType {
    var dishes: [OrderDTO] { get set }
}

class BasketManager: BasketManagerType {
    private init() {}
    
    static let shared = BasketManager()
    
    let authService: AuthServiceType = AuthService.shared
    let webApi: WebApiServiceType = WebApiService.shared

    var dishes: [OrderDTO] = []
    
    
}

