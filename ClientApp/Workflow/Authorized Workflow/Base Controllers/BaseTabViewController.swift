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
            return UITabBarItem(title: nil, image: UIImage(), selectedImage: nil)
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
            vc = UINavigationController(rootViewController: MainViewController(vm: MainViewModel()))
        case .Basket:
            vc = UINavigationController(rootViewController: BasketViewController())
        case .QRCode:
            vc = UINavigationController()
        case .Branch:
            vc = UINavigationController(rootViewController: BranchViewController(vm: BranchViewModel()))
        case .Profile:
            vc = UINavigationController(rootViewController: ProfileViewController(vm: ProfileViewModel()))
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
        setupMiddleButton()
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
    
    func setupMiddleButton() {
        let menuButton = UIButton(frame: CGRect(x: 0, y: 0, width: 67, height: 67))
        var menuButtonFrame = menuButton.frame
        menuButtonFrame.origin.y = view.bounds.height - menuButtonFrame.height - 30
        menuButtonFrame.origin.x = view.bounds.width/2 - menuButtonFrame.size.width/2
        menuButton.frame = menuButtonFrame
        
        menuButton.backgroundColor = Colors.orange.color
        menuButton.layer.cornerRadius = menuButtonFrame.height/2
        view.addSubview(menuButton)
        
        menuButton.setImage(Icons.qrCode.image, for: .normal)
        menuButton.tintColor = .white
        menuButton.addTarget(self, action: #selector(menuButtonAction(sender:)), for: .touchUpInside)
        
        view.layoutIfNeeded()
    }
    
    // MARK: - Actions
    
    @objc private func menuButtonAction(sender: UIButton) {
        let QRCodeVC = QRCodeViewController()
        let controller = SheetViewController(controller: QRCodeVC, sizes: [.percent(0.8)])
        controller.cornerRadius = 20
        present(controller, animated: true)
    }
}
