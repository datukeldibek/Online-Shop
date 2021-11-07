//
//  DoneViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 6/11/21.
//

import UIKit

class DoneViewController: BaseRegistrationViewController {

    private lazy var doneLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Авторизация завершена"
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        view.addSubview(doneLabel)
    }
    
    private func setUpConstaints () {
        doneLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(250)
        }
    }
}
