//
//  BirthdayViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 3/11/21.
//

import UIKit

class BirthdayViewController: BaseRegistrationViewController {
    private lazy var registrationLabel: UILabel = {
        let label = UILabel()
        label.text = "Регистрация"
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        label.textColor = .black
        return label
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите дату рождения для последующих персональных скидок"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var phoneTextField: RegistrationTextField = {
        let field = RegistrationTextField()
        field.setPlaceholder(with: "01.01.1991", color: .gray)
        field.setImage(with: Icons.Registration.phone.name)
        field.setBorderColor(with: .clear)
        field.setBackgroundColor(with: Colors.gray.color)
        field.setKeyboardType(with: .numberPad)
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return field
    }()
    
    private lazy var getCodeButton: RegistrationButton = {
        let button = RegistrationButton()
        button.setTitle("Войти")
        button.addTarget(self, action: #selector(getCodeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        view.addSubview(registrationLabel)
        view.addSubview(textLabel)
        view.addSubview(phoneTextField)
        view.addSubview(getCodeButton)
    }
    
    private func setUpConstaints () {
        registrationLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-50)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(35)
        }
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(registrationLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        getCodeButton.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }
    
    @objc
    private func getCodeButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
//       let confirmationCodeVC = ConfirmationCodeViewController(vm: AuthViewModel())
//        navigationController?.pushViewController(confirmationCodeVC, animated: true)
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        
    }
}
