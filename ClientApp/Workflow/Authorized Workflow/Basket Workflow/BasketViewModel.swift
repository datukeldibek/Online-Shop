//
//  BasketViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import Foundation

protocol BasketViewModelType {
    var dishes: [OrderDTO] { get }
}

class BasketViewModel: NSObject, BasketViewModelType {
    var authService: AuthServiceType
    var webApi: WebApiServiceType
    var basketManager: BasketManagerType
    
    init(webApi: WebApiServiceType, authService: AuthServiceType, basketManager: BasketManagerType) {
        self.webApi = webApi
        self.authService = authService
        self.basketManager = basketManager
    }
   
    var dishes: [OrderDTO] {
        basketManager.dishes
    }
}
