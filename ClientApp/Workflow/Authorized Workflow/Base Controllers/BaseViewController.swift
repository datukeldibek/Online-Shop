//
//  BaseViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
 
    private func setUp() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.backgroundColor = Colors.background.color
        navigationController?.navigationBar.barTintColor = Colors.background.color
        navigationController?.navigationBar.isTranslucent = false
        view.backgroundColor = Colors.background.color
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        
    }
    
    private func setUpConstaints () {
        
    }
}
