//
//  CategoryViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 2/12/21.
//

import UIKit
import XLPagerTabStrip

class CategoryViewController: BaseViewController {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let coll = UICollectionView(frame: .zero, collectionViewLayout: layout)
        coll.showsHorizontalScrollIndicator = false
        coll.showsVerticalScrollIndicator = false
        coll.delegate = self
        coll.dataSource = self
        coll.backgroundColor = Asset.clientBackround.color
        coll.registerReusableView(ViewType: HeaderView.self, type: .UICollectionElementKindSectionHeader)
        coll.registerReusable(CellType: PopularItemCell.self)
        coll.registerReusableView(ViewType: FooterView.self, type: .UICollectionElementKindSectionFooter)
        return coll
    }()
    // MARK: - Injection
    private var viewModel: MainViewModelType!
    
    private var selectedProducts: [ListOrderDetailsDto] = BasketManager.shared.getCart()
    
    private var dishes: [DishDTO] = [] {
        didSet {
            setCounter()
        }
    }
    
    private var products: [ListOrderDetailsDto] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var categoryName: String = ""
    
    var categoryIndex = 1 
    
    init(vm: MainViewModelType) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDishesByCategory(categoryId: categoryIndex)
        setUp()
    }
    override func viewWillAppear(_ animated: Bool) {
        selectedProducts = BasketManager.shared.getCart()
        setCounter()
        collectionView.reloadData()
    }
    
    func setCounter(gen: Bool = false) {
        products = dishes.map { item in
            let generalAdditionalIds = item.generalAdditionals?.map { GeneralAddition(generalAdditionalId: $0.id) }
            var count = 0
            for i in selectedProducts {
                if i.stockId == item.id {
                    count = i.quantity
                }
            }
            return ListOrderDetailsDto(
                stockId: item.dishId,
                urlImage: item.dishUrl,
                generalAdditionalId: gen ? generalAdditionalIds : nil,
                name: item.dishName,
                price: Int(item.dishPrice),
                quantity: count
            )
        }
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        view.addSubview(collectionView)
    }
    
    private func setUpConstaints () {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    // MARK: - Requests
    private func getDishesByCategory(categoryId: Int) {
        viewModel.getDishesByCategory(categoryId: categoryId) { [weak self] res in
            if case .success(let items) = res {
                self?.dishes = items
            }
        }
    }
}

extension CategoryViewController: IndicatorInfoProvider {
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: categoryName)
    }
}

extension CategoryViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueIdentifiableCell(PopularItemCell.self, for: indexPath)
        let item = products[indexPath.row]
        cell.display(cell: item)
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: screenWidth - 40, height: 90)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let headerView = collectionView.dequeuReusableView(ViewType: HeaderView.self, type: .UICollectionElementKindSectionHeader, for: indexPath)
            headerView.display(with: categoryName)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = InjectionService.resolve(controller: DetailsDishViewController.self)
        controller.selectedDish = dishes[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension CategoryViewController: PopularItemDelegate {
    func updateItems(with item: ListOrderDetailsDto) {
        item.quantity > 0 ? BasketManager.shared.addToCart(item) : BasketManager.shared.removeFromCart(product: item)
    }
}

// MARK: - HeaderView
extension CategoryViewController {
    class HeaderView: UICollectionReusableView { 
        private lazy var headerTitle: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
            label.textColor =  Asset.clientDarkBackround.color
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
