//
//  SplashAssembly.swift
//  ClientApp
//
//  Created by Iusupov Ramazan on 26/2/22.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class SplashAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(SplashViewModelType.self, initializer: SplashViewModel.init)
            .inObjectScope(.transient)
        
        container.register(SplashViewController.self) { r in
            SplashViewController(viewModel: r~>)
        }.inObjectScope(.container)
    }
}
