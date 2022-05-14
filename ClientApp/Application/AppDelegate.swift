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
    
    var window: UIWindow?
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let backImage = Asset.caretLeft.image.withRenderingMode(.alwaysOriginal)
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        window?.rootViewController = UINavigationController(rootViewController: DIService.shared.getVc(BaseTabViewController.self))
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
