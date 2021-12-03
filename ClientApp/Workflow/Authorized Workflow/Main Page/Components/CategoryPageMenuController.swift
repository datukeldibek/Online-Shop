//
//  CategoryPageMenuController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 2/12/21.
//

import UIKit
import XLPagerTabStrip

class CategoryPageMenuController: ButtonBarPagerTabStripViewController {
    
    private lazy var buttonBar: ButtonBarView = {
        let layout = UICollectionViewFlowLayout()
        let button = ButtonBarView(frame: .zero, collectionViewLayout: layout)
        button.backgroundColor = Colors.background.color
        return button
    }()
    
    private lazy var containerView1: UIScrollView = {
        let view = UIScrollView()
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = Colors.background.color
        return view
    }()
    
    override func viewDidLoad() {
        view.addSubview(buttonBar)
        view.addSubview(containerView1)
        buttonBarView = buttonBar
        containerView = containerView1
        buttonBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.trailing.leading.equalToSuperview()
            make.height.equalTo(50)
        }
        containerView1.snp.makeConstraints { make in
            make.top.equalTo(buttonBar.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        configurePageController()
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        moveToViewController(at: categoryIndex - 1, animated: true)
    }
    
    var categoryIndex = 0
    
    private func configurePageController() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.backgroundColor = Colors.background.color
        settings.style.buttonBarItemBackgroundColor = .clear
        settings.style.buttonBarBackgroundColor = Colors.background.color
        settings.style.selectedBarBackgroundColor = Colors.darkBackground.color
        settings.style.buttonBarItemFont = UIFont.systemFont(ofSize: 16, weight: .medium)
        settings.style.selectedBarHeight = 2
        settings.style.buttonBarItemTitleColor = .darkGray
        settings.style.buttonBarItemsShouldFillAvailableWidth = false
        settings.style.buttonBarMinimumInteritemSpacing = 2
        settings.style.buttonBarItemLeftRightMargin = 30
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let vm = MainViewModel()
        let teaController = CategoryViewController(vm: vm)
        teaController.categoryIndex = 1
        let сoffeeController = CategoryViewController(vm: vm)
        сoffeeController.categoryIndex = 2
        let bakeryController = CategoryViewController(vm: vm)
        bakeryController.categoryIndex = 3
        let desertsController = CategoryViewController(vm: vm)
        desertsController.categoryIndex = 4
        let cocktailsController = CategoryViewController(vm: vm)
        cocktailsController.categoryIndex = 5
        return [teaController, сoffeeController, bakeryController, desertsController, cocktailsController]
    }
}
