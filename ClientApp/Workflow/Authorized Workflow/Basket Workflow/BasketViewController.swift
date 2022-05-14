//
//  BasketViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import UIKit

class BasketViewController: BaseViewController {
    enum TypeSelected {
        case takeaway
        case intheCafe
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.textColor = .black
        label.text = "Корзина"
        return label
    }()
    
    private lazy var historyOfOrdersButton: UIButton = {
        let button = UIButton()
        button.setTitle("История", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        button.setTitleColor(Asset.clientOrange.color, for: .normal)
        button.addTarget(self, action: #selector(historyTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: 90)
        layout.minimumLineSpacing = 10
        layout.headerReferenceSize = CGSize(width: screenWidth, height: 130)
        layout.footerReferenceSize = CGSize(width: screenWidth, height: 240)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.registerReusable(CellType: OrderCell.self)
        view.registerReusableView(ViewType: BasketHeaderView.self, type: .UICollectionElementKindSectionHeader)
        view.registerReusableView(ViewType: BasketFooterView.self, type: .UICollectionElementKindSectionFooter)
        view.backgroundColor = Asset.clientBackround.color
        return view
    }()
    
    private let emptyView: UIImageView = {
        let view = UIImageView()
        let image = Asset.animal.image
        view.image = image
        return view
    }()
    
    private var sum = 0
    
    // MARK: - injection
    private var viewModel: BasketViewModelType
    
    init(vm: BasketViewModelType) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(historyOfOrdersButton)
        view.addSubview(collectionView)
    }
    
    private func setUpConstaints () {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(5)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(35)
        }
        historyOfOrdersButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(14)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(20)
            make.width.equalTo(85)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.trailing.leading.equalToSuperview()
        }
    }
    // MARK: - OBJC functions
    @objc
    private func historyTapped() {
        let historyVC = DIService.shared.getVc(HistoryOrderViewController.self)
        navigationController?.pushViewController(historyVC, animated: true)
    }
    
    private func orderInfo(sum: Int) {
        self.sum = sum
    }
}

// MARK: - Datasource Delegate
extension BasketViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueIdentifiableCell(OrderCell.self, for: indexPath)
        cell.orderCount = orderInfo
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let view = collectionView.dequeuReusableView(ViewType: BasketHeaderView.self, type: .UICollectionElementKindSectionHeader, for: indexPath)
            return view
        case UICollectionView.elementKindSectionFooter:
            let view = collectionView.dequeuReusableView(ViewType: BasketFooterView.self, type: .UICollectionElementKindSectionFooter, for: indexPath)
            view.delegate = self
            return view
        default:
            let view = collectionView.dequeuReusableView(ViewType: BasketFooterView.self, type: .UICollectionElementKindSectionFooter, for: indexPath)
            return view
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension BasketViewController: BasketFooterViewDelegate {
    func addMoreTap() {
        let tabbar = BaseTabViewController()
        tabbar.selectedIndex = 1
    }
    
    func orderTap() {
        print("tap")
    }
}
