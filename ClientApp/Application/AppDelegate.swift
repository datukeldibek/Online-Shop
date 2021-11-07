//
//  AppDelegate.swift
//  NeoCafe
//
//  Created by Рамазан Юсупов on 31/8/21.
//

import UIKit
import IQKeyboardManagerSwift
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
//    let assembler = Assembler([
//        ServiceAssembly(),
//        RegistrationAssembly()
//    ], container: SwinjectStoryboard.defaultContainer)
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let backImage = Icons.caretLeft.image.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        window?.rootViewController = UINavigationController(rootViewController: SplashViewController(viewModel: SplashViewModel()))
        window?.makeKeyAndVisible()
        
        IQKeyboardManager.shared.enable = true
        return true
    }
}

extension NSObject {
    
    var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }
    
    var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }
}
