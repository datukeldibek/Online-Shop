//
//  BaseTabViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import UIKit
import FittedSheets

enum TabBar: CaseIterable {
    case Home
    case Basket
    case Branch
    case Profile
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .Home: return UITabBarItem(title: nil, image: Asset.house.image, selectedImage: nil)
        case .Basket: return UITabBarItem(title: nil, image: Asset.toteSimple.image, selectedImage: nil)
        case .Branch: return UITabBarItem(title: nil, image: Asset.mapPin.image, selectedImage: nil)
        case .Profile: return UITabBarItem(title: nil, image: Asset.user.image, selectedImage: nil)
        }
    }
    
    var viewController: UINavigationController {
        var vc = UINavigationController()
        switch self {
        case .Home: vc = UINavigationController(rootViewController: InjectionService.resolve(controller: MainViewController.self))
        case .Basket: vc = UINavigationController(rootViewController: InjectionService.resolve(controller: BasketViewController.self))
        case .Branch: vc = UINavigationController(rootViewController: InjectionService.resolve(controller: BranchViewController.self))
        case .Profile: vc = UINavigationController(rootViewController: InjectionService.resolve(controller: ProfileViewController.self))
        }
        
        vc.setNavigationBarHidden(false, animated: false)
        vc.tabBarItem = tabBarItem
        return vc
    }
}

class BaseTabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        viewControllers = TabBar.allCases.map { $0.viewController }
        
        tabBar.itemPositioning = .centered
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.tintColor = UIColor.init(hexString: "30539f")
        tabBar.unselectedItemTintColor = .black
        tabBar.backgroundColor = Asset.clientWhite.color
        tabBar.itemWidth = (tabBar.frame.size.width / 4)
        
        tabBarItem.imageInsets = .init(top: 15, left: 5, bottom: 5, right: 5)
    }
}
