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

class BasketViewModel: BasketViewModelType {
 
    private let webApi: WebApiServiceType = WebApiService.shared
    private let basketManager: BasketManagerType = BasketManager.shared

    var dishes: [OrderDTO] {
        basketManager.dishes
    }
}
