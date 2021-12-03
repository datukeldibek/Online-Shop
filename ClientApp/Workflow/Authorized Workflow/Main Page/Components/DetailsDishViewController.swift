//
//  DetailsDishViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 3/12/21.
//

import UIKit

class DetailsDishViewController: BaseViewController {

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.registerReusable(CellType: PopularItemCell.self)
        coll.registerReusableView(ViewType: FooterView.self, type: .UICollectionElementKindSectionFooter)
        coll.registerReusableView(ViewType: HeaderView.self, type: .UICollectionElementKindSectionHeader)
        coll.delegate = self
        coll.dataSource = self
        return coll
    }()
    
    private var popularDishes: [FullCategoryDTO] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Injection
    private var viewModel: MainViewModelType
    
    init(vm: MainViewModelType) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("error with coder")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getPopularDishes()
    }

    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(collectionView)
    }
    
    private func setUpConstaints () {
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(220)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(25)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
            make.leading.trailing.equalTo(titleLabel)
            make.height.greaterThanOrEqualTo(30)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(30)
            make.bottom.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Requests
    private func getPopularDishes() {
        withRetry(viewModel.getPopularDishes) { [weak self] result in
            if case .success(let res) = result {
                self?.popularDishes = res
            }
        }
    }
}

extension DetailsDishViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return popularDishes.count > 3 ? 3 : popularDishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueIdentifiableCell(PopularItemCell.self, for: indexPath)
        cell.display(cell: popularDishes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: screenWidth - 40, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeuReusableView(ViewType: HeaderView.self, type: .UICollectionElementKindSectionHeader, for: indexPath)
            headerView.display(with: "Приятное дополнение")
            return headerView
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeuReusableView(ViewType: FooterView.self, type: .UICollectionElementKindSectionFooter, for: indexPath)
            return footerView
        default:
            let footerView = collectionView.dequeuReusableView(ViewType: FooterView.self, type: .UICollectionElementKindSectionFooter, for: indexPath)
            return footerView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        CGSize(width: screenWidth, height: 80)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        CGSize(width: screenWidth, height: 80)
    }
    
}
// MARK: - HeaderView
extension DetailsDishViewController {
    class HeaderView: UICollectionReusableView {
        
        private lazy var headerTitle: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
            label.textColor = .white
            return label
        }()
        
        override func layoutSubviews() {
            super.layoutSubviews()
            setUp()
        }
        private func setUp() {
            addSubview(headerTitle)
            headerTitle.snp.makeConstraints { make in
                make.top.leading.equalToSuperview().offset(16)
                make.bottom.trailing.equalToSuperview().offset(-16)
            }
        }
        
        func display(with text: String) {
            headerTitle.text = text
        }
    }
}
