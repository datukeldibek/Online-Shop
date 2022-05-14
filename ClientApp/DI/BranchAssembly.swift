//
//  BranchAssembly.swift
//  ClientApp
//
//  Created by Iusupov Ramazan on 14/5/22.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class BranchAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(BranchViewModelType.self, initializer: BranchViewModel.init)
            .inObjectScope(.transient)
        
        container.register(BranchViewController.self) { r in
            BranchViewController(vm: r~>)
        }.inObjectScope(.container)
    }
}
