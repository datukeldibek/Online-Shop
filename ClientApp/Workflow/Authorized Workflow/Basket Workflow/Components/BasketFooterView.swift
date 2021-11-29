//
//  BasketFooterView.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 13/11/21.
//

import UIKit

class BasketFooterView: UICollectionReusableView {
    private lazy var sumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var addMoreButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(Colors.orange.color, for: .normal)
        button.backgroundColor = Colors.background.color
        button.layer.borderColor = Colors.orange.color.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.setTitle("Добавить еще", for: .normal)
        return button
    }()
    
    private lazy var orderButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.orange.color
        button.layer.cornerRadius = 10
        button.setTitle("Заказать", for: .normal)
        return button
    }()
    
    var sum = 0 {
        didSet {
            sumLabel.attributedText = buildSumLabelAttributeText("\(sum) c")
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setUp()
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        addSubview(sumLabel)
        addSubview(addMoreButton)
        addSubview(orderButton)
    }
    
    private func setUpConstaints () {
        sumLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(25)
        }
        addMoreButton.snp.makeConstraints { make in
            make.top.equalTo(sumLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        orderButton.snp.makeConstraints { make in
            make.top.equalTo(addMoreButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
    }
    
    private func buildSumLabelAttributeText(_ item: String) -> NSMutableAttributedString {
        let attrs1 = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 22, weight: .semibold),
            NSAttributedString.Key.foregroundColor: Colors.orange.color
        ]

        let attrs2 = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold),
            NSAttributedString.Key.foregroundColor: UIColor.black
        ]

        let attributedString1 = NSMutableAttributedString(string: "Итого:", attributes: attrs2)
        
        let attributedString2 = NSMutableAttributedString(string: item, attributes: attrs1)

        attributedString1.append(attributedString2)
        
        return attributedString1
    }
}
