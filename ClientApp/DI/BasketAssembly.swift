//
//  BasketAssembly.swift
//  ClientApp
//
//  Created by Iusupov Ramazan on 26/2/22.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class BasketAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(BasketViewModelType.self, initializer: BasketViewModel.init)
            .inObjectScope(.transient)
        
        container.register(BasketViewController.self) { r in
            BasketViewController(vm: r~>)
        }.inObjectScope(.container)
        
        container.autoregister(HistoryOrderViewModelType.self, initializer: HistoryOrderViewModel.init)
            .inObjectScope(.transient)
        
        container.register(HistoryOrderViewController.self) { r in
            HistoryOrderViewController(vm: r~>)
        }.inObjectScope(.container)
        
        container.register(AddressViewController.self) { r in
            AddressViewController(vm: r~>)
        }.inObjectScope(.container)
    }
}
