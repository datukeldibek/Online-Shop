//
//  AddressViewController.swift
//  ClientApp
//
//  Created by Datu on 21/5/24.
//

import UIKit

class AddressViewController: BaseViewController {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.text = "Введите ваши данные"
        return label
    }()
    
    private lazy var city: RegistrationTextField = {
        let field = RegistrationTextField()
        field.setPlaceholder(with: "Город", color: .gray)
        field.setImage(with: "number")
        field.setBorderColor(with: .clear)
        field.setBackgroundColor(with: Asset.clientGray.color)
        field.setKeyboardType(with: .default)
        //field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return field
    }()
    
    private lazy var street: RegistrationTextField = {
        let field = RegistrationTextField()
        field.setPlaceholder(with: "Улица", color: .gray)
        field.setImage(with: "number")
        field.setBorderColor(with: .clear)
        field.setBackgroundColor(with: Asset.clientGray.color)
        field.setKeyboardType(with: .default)
        return field
    }()
    
    private lazy var numberOfHouse: RegistrationTextField = {
        let field = RegistrationTextField()
        field.setPlaceholder(with: "Номер дома", color: .gray)
        field.setImage(with: "number")
        field.setBorderColor(with: .clear)
        field.setBackgroundColor(with: Asset.clientGray.color)
        field.setKeyboardType(with: .default)
        return field
    }()
    
    private lazy var numberOFentrance: RegistrationTextField = {
        let field = RegistrationTextField()
        field.setPlaceholder(with: "Номер чего-то", color: .gray)
        field.setImage(with: "numbersign")
        field.setBorderColor(with: .clear)
        field.setBackgroundColor(with: Asset.clientGray.color)
        field.setKeyboardType(with: .default)
        return field
    }()
    
    private lazy var numberOfApartment: RegistrationTextField = {
        let field = RegistrationTextField()
        field.setPlaceholder(with: "Номер квартиры", color: .gray)
        field.setImage(with: "numbersign")
        field.setBorderColor(with: .clear)
        field.setBackgroundColor(with: Asset.clientGray.color)
        field.setKeyboardType(with: .default)
        return field
    }()
    
    private lazy var comment: RegistrationTextField = {
        let field = RegistrationTextField()
        field.setPlaceholder(with: "Комментарий", color: .gray)
        field.setImage(with: "note.text")
        field.setBorderColor(with: .clear)
        field.setBackgroundColor(with: Asset.clientGray.color)
        field.setKeyboardType(with: .default)
        return field
    }()
    
    private lazy var warning: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.text = "# - объязательное поле"
        return label
    }()
    
    private lazy var saveButton: RegistrationButton = {
        let button = RegistrationButton()
        button.setTitle("Получить код")
        button.isEnabled = false
        button.backgroundColor = .gray
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
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
        self.navigationItem.setHidesBackButton(true, animated: true)
        setUp()
        
        city.delegate = self
        street.delegate = self
        numberOfHouse.delegate = self
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(city)
        view.addSubview(street)
        view.addSubview(numberOfApartment)
        view.addSubview(numberOfHouse)
        view.addSubview(numberOFentrance)
        view.addSubview(comment)
        view.addSubview(warning)
        view.addSubview(saveButton)
    }
    
    private func setUpConstaints () {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(15)
            make.leading.equalToSuperview().offset(16)
            make.width.greaterThanOrEqualTo(30)
            make.height.equalTo(35)
        }
        
        warning.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        city.snp.makeConstraints { make in
            make.top.equalTo(warning.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        street.snp.makeConstraints { make in
            make.top.equalTo(city.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        
        numberOfHouse.snp.makeConstraints { make in
            make.top.equalTo(street.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        numberOFentrance.snp.makeConstraints { make in
            make.top.equalTo(numberOfHouse.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo((UIScreen.main.bounds.width - 40) / 2)
            make.height.equalTo(60)
        }
        
        numberOfApartment.snp.makeConstraints { make in
            make.top.equalTo(numberOfHouse.snp.bottom).offset(20)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo((UIScreen.main.bounds.width - 40) / 2)
            make.height.equalTo(60)
        }
        
        comment.snp.makeConstraints { make in
            make.top.equalTo(numberOfApartment.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(120)
        }
        
        saveButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }
    
    
    func setButtonstate() -> Bool {
        if city.text?.isEmpty == true {
            return false
        } else if street.text?.isEmpty == true {
            return false
        } else if numberOfHouse.text?.isEmpty == true {
            return false
        }
        
        return true
    }

    @objc
    private func buttonTapped() {
        let address = AddressInfoDTO(
            city: city.text ?? "",
            street: street.text ?? "",
            numberOfHouse: numberOfHouse.text ?? "",
            numberOFentrance: numberOFentrance.text ?? "",
            numberOfApartment: numberOfApartment.text ?? "",
            comment: comment.text ?? ""
        )
        
        if let encodedAddress = try? JSONEncoder().encode(address) {
            UserDefaults.standard.set(encodedAddress, forKey: "address")
        }
        navigationController?.popViewController(animated: true)
    }
    
}

extension AddressViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        saveButton.isEnabled = setButtonstate()
        saveButton.backgroundColor = setButtonstate() ? UIColor.init(hexString: "30539f") : .gray
    }
}
