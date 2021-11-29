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
        view.backgroundColor = Colors.background.color
        return view
    }()
    
    // MARK: - Injection
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

//    init(vm: ProfileViewModelType) {
//        viewModel = vm
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
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
}

extension HistoryOrderViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueIdentifiableCell(ProfileOrderCell.self, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.dequeuReusableView(ViewType: ProfileViewController.Header.self, type: .UICollectionElementKindSectionHeader, for: indexPath)
    }
}
