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
        button.setTitleColor(Colors.orange.color, for: .normal)
        button.addTarget(self, action: #selector(historyTapped), for: .touchUpInside)
        return button
    }()
    
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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: screenWidth, height: 90)
        layout.minimumLineSpacing = 10
        layout.footerReferenceSize = CGSize(width: screenWidth, height: 230)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.registerReusable(CellType: OrderCell.self)
        view.registerReusableView(ViewType: BasketFooterView.self, type: .UICollectionElementKindSectionFooter)
        view.backgroundColor = Colors.background.color
//        view.backgroundView = emptyView
        return view
    }()
    
    private let emptyView: UIImageView = {
        let view = UIImageView()
        let image = Icons.Basket.animal.image
        view.image = image
        return view
    }()
    
    private var type: TypeSelected = .takeaway {
        didSet {
            switch type {
            case .takeaway:
                takeawayButton.alpha = 1
                inTheCafeButton.alpha = 0.6
            case .intheCafe:
                takeawayButton.alpha = 0.6
                inTheCafeButton.alpha = 1
            }
        }
    }
    
    private var sum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(historyOfOrdersButton)
        view.addSubview(takeawayButton)
        view.addSubview(inTheCafeButton)
        view.addSubview(collectionView)

    }
    
    private func setUpConstaints () {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
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
        takeawayButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.height.equalTo(50)
            make.width.equalTo(152)
            make.leading.equalToSuperview().offset(24)
        }
        inTheCafeButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.height.equalTo(50)
            make.width.equalTo(152)
            make.trailing.equalToSuperview().offset(-24)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(inTheCafeButton.snp.bottom).offset(20)
            make.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    // MARK: - OBJC functions
   
    @objc
    private func TakeawayTapped() {
        type = .takeaway
    }
    
    @objc
    private func inTheCafeTapped() {
        type = .intheCafe
    }
    
    @objc
    private func historyTapped() {
        let historyVC = HistoryOrderViewController()
        navigationController?.pushViewController(historyVC, animated: true)
    }
    
    private func orderInfo(sum: Int) {
        self.sum = sum
    }
}

// MARK: - Datasource Delegate
extension BasketViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueIdentifiableCell(OrderCell.self, for: indexPath)
        cell.orderCount = orderInfo
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeuReusableView(ViewType: BasketFooterView.self, type: .UICollectionElementKindSectionFooter, for: indexPath)
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
