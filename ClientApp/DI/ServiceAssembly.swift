//
//  ServiceAssembly.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 4/11/21.
//

import Foundation
import Swinject
import SwinjectAutoregistration

//class ServiceAssembly: Assembly {
//    
//    func assemble(container: Container) {
//        container
//            .autoregister(WebApiServiceType.self, initializer: WebApiService.init(authService:decoder:))
//            .inObjectScope(.container)
//        
//        container
//            .autoregister(AuthServiceType.self, initializer: AuthService.init)
//            .initCompleted { (r, auth) in
//                if let service = auth as? AuthService {
//                    service.setNetworkService(r~>)
//                }
//        }.inObjectScope(.container)
//    }
//}
