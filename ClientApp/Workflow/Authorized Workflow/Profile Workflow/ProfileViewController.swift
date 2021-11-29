//
//  ProfileViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 7/11/21.
//

import UIKit

class ProfileViewController: BaseViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.text = "Ramazan"
        return label
    }()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(Icons.pencil.image, for: .normal)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(editProfileTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var bonusView: UIImageView = {
        let view = UIImageView()
        view.image = Icons.bonusImage.image
        let tap = UITapGestureRecognizer(target: self, action: #selector(bonusViewTapped))
        view.addGestureRecognizer(tap)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var bonusLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .white
        label.text = "Бонусы"
        return label
    }()
    
    private lazy var bonusAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.textColor = .white
        label.text = "100"
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
        view.registerReusableView(ViewType: Header.self, type: .UICollectionElementKindSectionHeader)
        view.backgroundColor = Colors.background.color
        return view
    }()
    
    // MARK: - Injection
    var viewModel: ProfileViewModelType!
    
    private var bonus = 0 {
        didSet {
            bonusAccountLabel.text = "\(bonus)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        getBonuses()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavBar()
    }
    
    init(vm: ProfileViewModelType) {
        viewModel = vm
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(bonusView)
        view.addSubview(editButton)
        bonusView.addSubview(bonusLabel)
        bonusView.addSubview(bonusAccountLabel)
        view.addSubview(collectionView)
    }
    
    private func setUpConstaints () {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalToSuperview().offset(16)
            make.width.greaterThanOrEqualTo(30)
            make.height.equalTo(35)
        }
        editButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel).offset(3)
            make.leading.equalTo(titleLabel.snp.trailing).offset(10)
            make.width.height.equalTo(25)
        }
        bonusView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(130)
        }
        bonusLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(24)
            make.height.equalTo(25)
            make.width.greaterThanOrEqualTo(85)
        }
        bonusAccountLabel.snp.makeConstraints { make in
            make.top.equalTo(bonusLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(24)
            make.height.equalTo(35)
            make.width.greaterThanOrEqualTo(85)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(bonusView.snp.bottom).offset(20)
            make.bottom.trailing.leading.equalToSuperview()
        }
    }
    
    private func configureNavBar() {
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = Colors.background.color
        navigationItem.title = "Профиль"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Icons.Profile.signOut.image,
            style: .done,
            target: self,
            action: #selector(logOutTapped)
        )
    }
    
    // MARK: - Requests
    private func getBonuses() {
        viewModel.getBonuses { [weak self] res in
            if case .success(let bonus) = res {
                self?.bonus = bonus
            }
        }
    }
    
    private func addSubstractBonuses(amount: Int) {
        viewModel.addSubstractBonuses(amount: 10) { [weak self] res in
            if case .success(let bonus) = res {
                self?.bonus = bonus
                self?.getBonuses()
            }
        }
    }
    
    // MARK: - OBJC functions
    @objc
    private func logOutTapped() {
        viewModel.logOut()
        dismiss(animated: true)
    }
    
    @objc
    private func editProfileTapped() {
        let ProfileEditVC = ProfileEditViewController(vm: ProfileViewModel())
        navigationController?.pushViewController(ProfileEditVC, animated: true)
    }
    
    @objc private func bonusViewTapped() {
        let alert = UIAlertController(
            title: "Бонусы",
            message: "Накапливайте бонусы и совершайте выгодные для Вас заказы! 1 бонус = 1 сом",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Хорошо", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - Collection delegate datasource
extension ProfileViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueIdentifiableCell(ProfileOrderCell.self, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        collectionView.dequeuReusableView(ViewType: Header.self, type: .UICollectionElementKindSectionHeader, for: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addSubstractBonuses(amount: 10)
    }
}
