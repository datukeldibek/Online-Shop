//
//  HeaderItemView.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 23/11/21.
//

import UIKit

class HeaderItemView: UICollectionReusableView {
    let label: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        text.numberOfLines = 0
        return text
    }()
    
    let buttonLabel: UILabel = {
        let text = UILabel()
        text.textColor = .black
        text.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return text
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setUp() {
        backgroundColor = Asset.clientBackround.color
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        addSubview(label)
        addSubview(buttonLabel)
    }
    
    private func setUpConstaints () {
        label.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview().inset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        buttonLabel.snp.makeConstraints { make in
            make.lastBaseline.equalTo(label.snp.lastBaseline)
            make.trailing.equalToSuperview().inset(16)
        }
    }
}

class FooterView: UICollectionReusableView {
    let view = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addSubview(view)
        view.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.trailing.leading.equalToSuperview()
        }
    }
}
