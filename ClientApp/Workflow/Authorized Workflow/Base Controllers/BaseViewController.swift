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
        view.backgroundColor = Colors.background.color
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        
    }
    
    private func setUpConstaints () {
        
    }
}
