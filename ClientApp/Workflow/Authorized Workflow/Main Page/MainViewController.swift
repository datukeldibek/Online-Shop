//
//  MainViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import UIKit
import AVFoundation

class MainViewController: BaseViewController {
    
    enum Section: String, CaseIterable {
        case header = ""
        case category = "Наше меню"
        case popular = "Популярное"
    }
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: generateLayout())
        collectionView.registerReusableView(ViewType: BonusItemCell.self, type: .UICollectionElementKindSectionHeader)
        collectionView.registerReusable(CellType: CategoryItemCell.self)
        collectionView.registerReusable(CellType: PopularItemCell.self)
        collectionView.registerReusableView(ViewType: HeaderItemView.self, type: .UICollectionElementKindSectionHeader)
        collectionView.registerReusableView(ViewType: FooterView.self, type: .UICollectionElementKindSectionFooter)
        collectionView.backgroundColor = Colors.background.color
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - Injection
    var viewModel: MainViewModelType
    
    private var popularDishes: [FullCategoryDTO] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var categories: [CategoryDTO] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var bonus: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init(vm: MainViewModelType) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getBonuses()
        getCategories()
        getPopularDishes()
        setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCategories()
        getBonuses()
        getPopularDishes()
    }
    
    private func setUp() {
        setUpSubviews()
    }
    
    private func setUpSubviews() {
        view.addSubview(collectionView)
    }
    
    // MARK: - Requests
    private func getPopularDishes() {
        withRetry(viewModel.getPopularDishes) { [weak self] result in
            if case .success(let res) = result {
                self?.popularDishes = res
            }
        }
    }
    
    private func getCategories() {
        withRetry(viewModel.getCategoriesDish) { [weak self] result in
            if case .success(let res) = result {
                self?.categories = res
            }
        }
    }
    
    private func getBonuses() {
        viewModel.getBonuses { [weak self] res in
            if case .success(let bonus) = res {
                self?.bonus = bonus
            }
        }
    }
}

// MARK: - Delegate Datasource
extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Section.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return categories.count
        } else {
            return popularDishes.count > 3 ? 3 : popularDishes.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = UICollectionViewCell()
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueIdentifiableCell(CategoryItemCell.self, for: indexPath)
            cell.display(cell: self.categories[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueIdentifiableCell(PopularItemCell.self, for: indexPath)
            cell.display(cell: self.popularDishes[indexPath.row])
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if indexPath.section == 0 {
                let headerView = collectionView.dequeuReusableView(ViewType: BonusItemCell.self, type: .UICollectionElementKindSectionHeader, for: indexPath)
                headerView.display(bonus: self.bonus)
                return headerView
            }
            let supplementaryView = collectionView.dequeuReusableView(ViewType: HeaderItemView.self, type: .UICollectionElementKindSectionHeader, for: indexPath)
            supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
            return supplementaryView
        case UICollectionView.elementKindSectionFooter:
            let footer = collectionView.dequeuReusableView(ViewType: FooterView.self, type: .UICollectionElementKindSectionFooter, for: indexPath)
            return footer
        default:
            let footer = collectionView.dequeuReusableView(ViewType: FooterView.self, type: .UICollectionElementKindSectionFooter, for: indexPath)
            return footer
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let controller = CategoryPageMenuController()
            switch categories[indexPath.row].name {
            case "Кофе":
                controller.categoryIndex = 2
            case "Десерты":
                controller.categoryIndex = 4
            case "Коктейли":
                controller.categoryIndex = 5
            case "Выпечка":
                controller.categoryIndex = 3
            case "Чай":
                controller.categoryIndex = 1
            default:
                controller.categoryIndex = 1
            }
            navigationController?.pushViewController(controller, animated: true)
        }
    }
}


// MARK: - Collection Layout
extension MainViewController {
    func generateLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let sectionLayoutKind = Section.allCases[sectionIndex]
            switch sectionLayoutKind {
            case .header:
                return self.generateHeaderLayout()
            case .popular:
                return self.generatePopularItemsLayout()
            case .category:
                return self.generateCategoryItemsLayout()
            }
        }
        return layout
    }
    
    func generateHeaderLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .absolute(1),
            heightDimension: .absolute(1))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(1),
            heightDimension: .absolute(1)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 1
        )
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(130)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        sectionHeader.pinToVisibleBounds = true
        sectionHeader.zIndex = 2
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func generateCategoryItemsLayout() -> NSCollectionLayoutSection {
        let doubleItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0)
        )
        
        let doubleItem = NSCollectionLayoutItem(layoutSize: doubleItemSize)
        
        doubleItem.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 8,
            bottom: 8,
            trailing: 8
        )
        
        let doubleGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/2.4)
        )
        
        let doubleGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: doubleGroupSize,
            subitem: doubleItem,
            count: 2
        )
        
        let tripletItem = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1/3),
                heightDimension: .fractionalHeight(1)))
        
        tripletItem.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 8,
            bottom: 0,
            trailing: 8
        )
        
        let tripletGroup = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(1/3)),
            subitems: [tripletItem, tripletItem, tripletItem])
        
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalWidth(0.75)),
            subitems: [
                doubleGroup,
                tripletGroup
            ]
        )
        
        nestedGroup.contentInsets = NSDirectionalEdgeInsets(
            top: 0,
            leading: 8,
            bottom: 0,
            trailing: 8
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        sectionHeader.pinToVisibleBounds = true
        sectionHeader.zIndex = 2
        
        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.boundarySupplementaryItems = [sectionHeader]
        return section
    }
    
    func generatePopularItemsLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.2594752187)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = NSDirectionalEdgeInsets(top: 9, leading: 16, bottom: 9, trailing: 16)
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(44)
        )
        
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        sectionHeader.pinToVisibleBounds = true
        sectionHeader.zIndex = 2
        
        let footerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(100)
        )
        
        let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: footerSize,
            elementKind: UICollectionView.elementKindSectionFooter,
            alignment: .bottom
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
        section.orthogonalScrollingBehavior = .none
        
        return section
    }
}

extension MainViewController: PopularItemDelegate {
    func updateItems(with items: OrderDTO) {
        viewModel.dishesInBasket.append(items)
    }
}
