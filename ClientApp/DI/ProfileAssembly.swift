//
//  ProfileAssembly.swift
//  ClientApp
//
//  Created by Iusupov Ramazan on 26/2/22.
//

import Foundation
import Swinject
import SwinjectAutoregistration

class ProfileAssembly: Assembly {
    func assemble(container: Container) {
        container.autoregister(ProfileViewModelType.self, initializer: ProfileViewModel.init)
            .inObjectScope(.transient)
        
        container.register(ProfileViewController.self) { r in
            ProfileViewController(vm: r~>)
        }.inObjectScope(.container)
        
        container.register(ProfileEditViewController.self) { r in
            ProfileEditViewController(vm: r~>)
        }.inObjectScope(.container)
    }
}
