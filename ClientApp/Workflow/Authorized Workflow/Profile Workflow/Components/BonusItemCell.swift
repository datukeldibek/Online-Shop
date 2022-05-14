//
//  BonusItemCell.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 23/11/21.
//

import UIKit

protocol BonusItemCellDelegate: AnyObject {
    func openView()
}

class BonusItemCell: UICollectionReusableView {
    public lazy var view: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 25
        let tap = UITapGestureRecognizer(target: self, action: #selector(openView))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    public lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = Asset.bonusImage.image
        image.layer.cornerRadius = 25
        return image
    }()
    
    public lazy var bonusStaticLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Бонусы"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = UIColor.white
        return label
    }()
    
    public lazy var bonusNumberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = UIColor.white
        label.text = "100"
        return label
    }()
    
    weak var delegate: BonusItemCellDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        backgroundColor = Asset.clientBackround.color
        layer.cornerRadius = 25
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        addSubview(image)
        addSubview(view)
        
        view.addSubview(bonusStaticLabel)
        view.addSubview(bonusNumberLabel)
    }
    
    private func setUpConstaints () {
        image.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
        }
        view.snp.makeConstraints { make in
            make.height.equalTo(image.snp.height).multipliedBy(0.73)
            make.width.equalTo(image.snp.width).multipliedBy(0.8)
            make.centerY.centerX.equalToSuperview()
        }
        bonusStaticLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        bonusNumberLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func display(bonus: Int) {
        bonusNumberLabel.text = "\(bonus) c"
    }
    
    @objc
    private func openView() {
        delegate?.openView()
    }
}
