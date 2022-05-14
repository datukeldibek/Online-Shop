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
    var authService: AuthServiceType
    var webApi: WebApiServiceType
    
    init(webApi: WebApiServiceType, authService: AuthServiceType) {
        self.webApi = webApi
        self.authService = authService
    }

    var dishes: [OrderDTO] = []
}

