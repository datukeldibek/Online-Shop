//
//  BasketHeaderView.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 1/12/21.
//

import UIKit

protocol BasketHeaderDelegate: AnyObject {
    func typeTapped()
}

class BasketHeaderView: UICollectionReusableView {
    
    private lazy var takeawayButton: RegistrationButton = {
        let button = RegistrationButton()
        button.setTitle("Возьму с собой")
        button.isInvert()
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(TakeawayTapped), for: .touchUpInside)
        return button
    }()

    private lazy var inTheCafeButton: RegistrationButton = {
        let button = RegistrationButton()
        button.setTitle("В заведении")
        button.addTarget(self, action: #selector(inTheCafeTapped), for: .touchUpInside)
        return button
    }()

    weak var delegate: BasketHeaderDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        addSubview(takeawayButton)
        addSubview(inTheCafeButton)
    }
    
    private func setUpConstaints () {
        takeawayButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(50)
            make.width.equalTo(152)
            make.leading.equalToSuperview().offset(24)
        }
        inTheCafeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.height.equalTo(50)
            make.width.equalTo(152)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
    
    @objc
    private func TakeawayTapped() {
       
    }
    
    @objc
    private func inTheCafeTapped() {
        
    }
}
