//
//  ServiceAssembly.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 4/11/21.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(WebApiServiceType.self, initializer: WebApiService.init)
            .inObjectScope(.container)
        
        container.autoregister(AuthServiceType.self, initializer: AuthService.init).initCompleted { (r, s) in
            if let authS = s as? AuthService {
                authS.setWebService(r~>)
            }
        }.inObjectScope(.container)

        
        container.autoregister(KeyValueStoreType.self, initializer: TransientStorageService.init)
            .inObjectScope(.container)
        
        container.autoregister(BasketManagerType.self, initializer: BasketManager.init)
            .inObjectScope(.container)
    }
}

