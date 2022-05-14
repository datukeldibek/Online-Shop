//
//  DIService.swift
//  ClientApp
//
//  Created by Iusupov Ramazan on 12/5/22.
//

import Swinject
import SwinjectAutoregistration
import UIKit

class DIService: NSObject {
    
    static var shared = DIService()
    
    var DIArray: [Assembly] = [
        ServiceAssembly(),
        SplashAssembly(),
        RegistrationAssembly(),
        AuthorizationAssembly(),
        HomePageAssembly(),
        BasketAssembly(),
        ProfileAssembly(),
        BranchAssembly()
    ]
    
    func getVc<T: UIViewController>(_ vc: T.Type) -> T {
        let container = Container()
        let assembler = Assembler(DIArray, container: container)
        return assembler.resolver.resolve(T.self)!
    }
}
