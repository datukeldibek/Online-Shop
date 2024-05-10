//
//  AuthorizationAssembly.swift
//  ClientApp
//
//  Created by Iusupov Ramazan on 26/2/22.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class AuthorizationAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(AuthViewModelType.self, initializer: AuthViewModel.init)
            .inObjectScope(.transient)
        
        container.register(AuthViewController.self) { r in
            AuthViewController(vm: r~>)
        }.inObjectScope(.transient)
        
        container.register(ConfirmationCodeViewController.self) { r in
            ConfirmationCodeViewController(vm: r~>)
        }.inObjectScope(.transient)
        
        container.register(QRCodeViewController.self) { r in
            QRCodeViewController()
        }.inObjectScope(.transient)
        
        container.register(BaseTabViewController.self) { _ in
            BaseTabViewController()
        }.inObjectScope(.transient)
    }
}
