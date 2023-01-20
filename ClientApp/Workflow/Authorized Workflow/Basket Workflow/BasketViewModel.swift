//
//  BasketViewModel.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import Foundation

protocol BasketViewModelType {
    func getDishes() -> [OrderType]
}

class BasketViewModel: NSObject, BasketViewModelType {
    var authService: AuthServiceType
    var webApi: WebApiServiceType
    var basketManager: BasketManagerType
    
    private var dishes: [OrderType] = []
    
    init(webApi: WebApiServiceType, authService: AuthServiceType, basketManager: BasketManagerType) {
        self.webApi = webApi
        self.authService = authService
        self.basketManager = basketManager
    }
    
    func getDishes() -> [OrderType] {
        let items = basketManager.getDishes()
        dishes = items
        return items
    }
}
