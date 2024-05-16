//
//  CategoryItemCell.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 23/11/21.
//

import UIKit

class CategoryItemCell: UICollectionViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.adjustsFontForContentSizeCategory = true
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 2
        label.layer.masksToBounds = false
        return label
    }()
    
    private lazy var featuredPhotoView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private lazy var contentContainer: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private lazy var imageView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    var containerWidth: Double = 0
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        contentView.addSubview(contentContainer)
        contentView.addSubview(featuredPhotoView)
        
        contentContainer.addSubview(imageView)
        contentContainer.addSubview(titleLabel)
        
        imageView.addSubview(featuredPhotoView)
        
        featuredPhotoView.clipsToBounds = true
        
        imageView.backgroundColor = UIColor(red: 1, green: 0.88, blue: 0.454, alpha: 1)
        imageView.layer.cornerRadius = 20
       
//        contentContainer.backgroundColor = .orange
        
        setupConstraint()
        containerWidth = contentContainer.frame.size.width
        print("width = \(containerWidth)")
       
    }
    
    func setupConstraint() {
        contentContainer.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(120)
        }
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(26)
        }
        featuredPhotoView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.height).multipliedBy(0.65)
            make.width.equalTo(featuredPhotoView.snp.height)
            make.centerX.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { make in
            if Double(contentContainer.bounds.width) > 100.0 {
                make.top.equalTo(imageView.snp.bottom)
            } else {
                make.top.equalTo(imageView.snp.bottom).offset(-10)
            }
            
            make.bottom.equalToSuperview()
            make.width.equalTo(contentContainer.snp.width)
            make.centerX.equalToSuperview()
            
        }
    }
    
    func display(cell: CategoryDTO) {
        titleLabel.text = cell.name
        
        switch cell.id {
        case 1:
            featuredPhotoView.image = Asset.skincare.image
        case 2:
            featuredPhotoView.image = Asset.makeup.image
        case 3:
            featuredPhotoView.image = Asset.hair.image
        case 4:
            featuredPhotoView.image = Asset.parfume.image
        case 5:
            featuredPhotoView.image = Asset.spf.image
        default:
            featuredPhotoView.image = Asset.spf.image
        }
    }
}
