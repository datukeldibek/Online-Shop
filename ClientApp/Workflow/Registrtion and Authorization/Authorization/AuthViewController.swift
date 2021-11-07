//
//  AuthViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 3/11/21.
//

import UIKit

class AuthViewController: BaseRegistrationViewController {
    private lazy var authLabel: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        label.textColor = .black
        return label
    }()
    
    private lazy var phoneTextField: RegistrationTextField = {
        let field = RegistrationTextField()
        field.setPlaceholder(with: "5555555", color: .gray)
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
    
    // MARK: - Injection
    var viewModel: AuthViewModelType
    
    private var isLoading = false
    private var searchTerm: String?
    private var countryCode = "+996"
    
    init(viewModel vm: AuthViewModelType) {
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
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
    }
    
    private func setUpSubviews() {
        view.addSubview(authLabel)
        view.addSubview(phoneTextField)
        view.addSubview(getCodeButton)
    }
    
    private func setUpConstaints () {
        authLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().inset(90)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(35)
        }
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(authLabel.snp.bottom).offset(35)
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
      requestCode()
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        
    }
    
    // MARK: - Request
    func requestCode() {
        guard let phone = phoneTextField.text,
              phone.count > 8  else { return }
        phoneTextField.resignFirstResponder()
        isLoading = true
        
        let fullPhone = countryCode + phone
        let authPayload = AuthorizationDTO(phoneNumber: fullPhone)
        let requestCode = { [unowned self] completion in
            self.viewModel.authorizeUser(user: authPayload, completion: completion)
        }
        
        withRetry(requestCode) { [weak self] (res) in
            self?.isLoading = false
            if case .success = res {
                let confirmationCodeVC = ConfirmationCodeViewController(vm: AuthViewModel())
                confirmationCodeVC.phoneNumber = fullPhone
                self?.navigationController?.pushViewController(confirmationCodeVC, animated: true)
            }
        }
    }
}
