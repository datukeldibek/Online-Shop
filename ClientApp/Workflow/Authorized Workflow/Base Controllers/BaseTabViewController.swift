//
//  BaseTabViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import UIKit

enum TabBar: CaseIterable {
    case Home
    case Basket
    case QRCode
    case Branch
    case Profile
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .Home:
            return UITabBarItem(title: nil, image: Icons.house.image, selectedImage: nil)
        case .Basket:
            return UITabBarItem(title: nil, image: Icons.toteSimple.image, selectedImage: nil)
        case .QRCode:
            return UITabBarItem(title: nil, image: Icons.qrCode.image, selectedImage: nil)
        case .Branch:
            return UITabBarItem(title: nil, image: Icons.mapPin.image, selectedImage: nil)
        case .Profile:
            return UITabBarItem(title: nil, image: Icons.Registration.user.image, selectedImage: nil)
        }
    }
    
    var viewController: UINavigationController {
        var vc = UINavigationController()
        switch self {
        case .Home:
            vc = UINavigationController(rootViewController: MainViewController())
        case .Basket:
            vc = UINavigationController(rootViewController: BasketViewController())
        case .QRCode:
            vc = UINavigationController(rootViewController: QRCodeViewController())
        case .Branch:
            vc = UINavigationController(rootViewController: BranchViewController())
        case .Profile:
            vc = UINavigationController(rootViewController: ProfileViewController())
        }
        
        vc.setNavigationBarHidden(true, animated: false)
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
        viewControllers = TabBar.allCases.map({ $0.viewController })
        
        tabBar.itemPositioning = .centered
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.tintColor = Colors.orange.color
        tabBar.backgroundColor = Colors.background.color
        tabBar.itemWidth = (tabBar.frame.size.width / 5)
    }
}
