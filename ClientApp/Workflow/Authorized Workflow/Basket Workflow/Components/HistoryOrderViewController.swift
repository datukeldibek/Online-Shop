//
//  HistoryOrderViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 13/11/21.
//

import UIKit

class HistoryOrderViewController: BaseViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.text = "Ramazan"
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.width, height: 105)
        layout.headerReferenceSize = CGSize(width: 170, height: 60)
        layout.minimumLineSpacing = 10
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.delegate = self
        view.dataSource = self
        view.registerReusable(CellType: ProfileOrderCell.self)
        view.registerReusableView(ViewType: ProfileViewController.Header.self, type: .UICollectionElementKindSectionHeader)
        view.backgroundColor = Asset.clientBackround.color
        return view
    }()
    
    private var currentOrders: [HistoryDTO] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    private var completedOrders: [HistoryDTO] = []{
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - Injection
    private var viewModel: HistoryOrderViewModelType
    
    init(vm: HistoryOrderViewModelType) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getUserInfo()
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(collectionView)
    }
    
    private func setUpConstaints () {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalToSuperview().offset(16)
            make.width.greaterThanOrEqualTo(30)
            make.height.equalTo(35)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    private func getUserInfo() {
        withRetry(viewModel.getUserInfo) { [weak self] res in
            if case .success(let info) = res {
                self?.setUserInfo(user: info)
            }
        }
    }
    
    private func getCurrentOrders() {
        withRetry(viewModel.getCurrentOrders) { [weak self] res in
            if case .success(let items) = res {
                self?.currentOrders = items
            }
        }
    }
    
    private func getComletedOrders() {
        withRetry(viewModel.getCompletedOrders) { [weak self] res in
            if case .success(let items) = res {
                self?.completedOrders = items
            }
        }
    }
    
    private func setUserInfo(user: UserProfileDTO) {
        titleLabel.text = user.name
    }
}

extension HistoryOrderViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return currentOrders.count
        }
        return completedOrders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueIdentifiableCell(ProfileOrderCell.self, for: indexPath)
        if indexPath.section == 0 {
            cell.display(currentOrders[indexPath.row])
        } else {
            cell.display(completedOrders[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeuReusableView(ViewType: ProfileViewController.Header.self, type: .UICollectionElementKindSectionHeader, for: indexPath)
        if indexPath.section == 0 {
            headerView.display(with: .current)
        } else {
            headerView.display(with: .closed)
        }
        return headerView
    }
}
