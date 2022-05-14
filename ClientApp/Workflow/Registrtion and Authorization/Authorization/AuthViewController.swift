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
        field.setPlaceholder(with: "505-21-11-02", color: .gray)
        field.setImage(with: Asset.phone.name)
        field.setBorderColor(with: .clear)
        field.setBackgroundColor(with: Asset.clientGray2.color)
        field.setKeyboardType(with: .numberPad)
        field.tintColor = .black
        field.delegate = self
        return field
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(phoneTextField)
        stack.addArrangedSubview(errorLabel)
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        return stack
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
    
    init(vm: AuthViewModelType) {
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
        view.addSubview(stackView)
    }
    
    private func setUpConstaints () {
        authLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().inset(90)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(35)
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(authLabel.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(80)
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
    
    // MARK: - Request
    func requestCode() {
        guard let phone = phoneTextField.text,
              phone.count > 13 else {
                  phoneTextField.setMistakeLabel(to: "Phone is not filled", textColor: .red)
            return
        }
        phoneTextField.resignFirstResponder()
        getCodeButton.isLoading = true

        let fullPhone = phone.replacingOccurrences(of: " ", with: "")
        let authPayload = AuthorizationDTO(phoneNumber: fullPhone)
        let requestCode = { [unowned self] completion in
            self.viewModel.authorizeUser(user: authPayload, completion: completion)
        }

        withRetry(requestCode) { [weak self] res in
            guard let `self` = self else { return }
            if case .success = res {
                let confirmationCodeVC = DIService.shared.getVc(ConfirmationCodeViewController.self)
                confirmationCodeVC.phoneNumber = fullPhone
                self.navigationController?.pushViewController(confirmationCodeVC, animated: true)
            }
            self.getCodeButton.isLoading = false
        }
    }
}

extension AuthViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        requestCode()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text?.isEmpty ?? true {
            textField.text = "+996 "
        }
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard var text = textField.text else { return }
        if text.count > 14 {
            phoneTextField.setMistakeLabel(to: "Invalid phone number length")
            text.removeLast()
            textField.text = text
        } else {
            phoneTextField.setMistakeLabel(to: "")
        }
    }
}
