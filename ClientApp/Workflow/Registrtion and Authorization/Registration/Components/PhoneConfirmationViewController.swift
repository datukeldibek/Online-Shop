//
//  PhoneConfirmationViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 3/11/21.
//

import UIKit

class PhoneConfirmationViewController: BaseRegistrationViewController {
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.text = "Введите 4-х значный код, отправленный на номер 0552 321 123"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var textField1: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        field.textAlignment = .center
        field.keyboardType = .numberPad
        field.textContentType = .oneTimeCode
        field.backgroundColor = Colors.background.color
        return field
    }()
    
    private lazy var textField2: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        field.textAlignment = .center
        field.keyboardType = .numberPad
        field.textContentType = .oneTimeCode
        field.backgroundColor = Colors.background.color
        return field
    }()
    
    private lazy var textField3: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        field.textAlignment = .center
        field.keyboardType = .numberPad
        field.textContentType = .oneTimeCode
        field.backgroundColor = Colors.background.color
        return field
    }()
    
    private lazy var textField4: UITextField = {
        let field = UITextField()
        field.textColor = .black
        field.font = UIFont.systemFont(ofSize: 40, weight: .regular)
        field.textAlignment = .center
        field.keyboardType = .numberPad
        field.textContentType = .oneTimeCode
        field.backgroundColor = Colors.background.color
        return field
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stack = UIStackView()
        stack.addArrangedSubview(textField1)
        stack.addArrangedSubview(textField2)
        stack.addArrangedSubview(textField3)
        stack.addArrangedSubview(textField4)
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .fill
        stack.spacing = 2
        return stack
    }()
    
    private lazy var logInButton: RegistrationButton = {
        let button = RegistrationButton()
        button.setTitle("Войти")
        button.addTarget(self, action: #selector(getCodeTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var resendButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.gray, for: .normal)
        button.setTitle("Отправить ещё раз", for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(getCodeTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private var countryCode = "+996"
    private var confirmationCode = ""
    var phoneNumber = ""
    
    // MARK: - Injection
    public var viewModel: PhoneRegistrationViewModelType
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    init(vm: PhoneRegistrationViewModelType) {
          viewModel = vm
          super.init(nibName: nil, bundle: nil)
      }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    private func setUp() {
        setUpSubviews()
        setUpConstaints()
        configure()
    }
    
    private func configure() {
        configureTextField()
    }
    
    private func setUpSubviews() {
        view.addSubview(textLabel)
        view.addSubview(horizontalStack)
        view.addSubview(logInButton)
        view.addSubview(resendButton)
    }
    
    private func setUpConstaints () {
        textLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.trailing.equalToSuperview().inset(30)
            make.centerY.equalToSuperview().inset(40)
        }
        horizontalStack.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(40)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.width.equalTo(screenWidth * 180 / 375)
        }
        logInButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(horizontalStack.snp.bottom).offset(50)
            make.height.equalTo(60)
        }
        resendButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.top.equalTo(logInButton.snp.bottom).offset(16)
            make.height.equalTo(60)
        }
    }
    
    private func configureTextField() {
        textField1.delegate = self
        textField2.delegate = self
        textField3.delegate = self
        textField4.delegate = self
        textField1.setBottomBorder()
        textField2.setBottomBorder()
        textField3.setBottomBorder()
        textField4.setBottomBorder()
    }
    
    @objc
    private func getCodeTapped(_ sender: UIButton) {
        checkCode()
    }
    
    private func checkCode() {
        if phoneNumber.count > 8,
           confirmationCode.count > 3 {
            let fullPhone = countryCode + phoneNumber
            let confirmationCodeCompletion = { [unowned self] completion in
                self.viewModel.sendConfirmation(for: fullPhone, confirmationCode: self.confirmationCode, completion: completion)
            }
            
            withRetry(confirmationCodeCompletion) { [weak self] res in
                if case .success = res {
                    let birthdayVC = BirthdayViewController()
                    self?.navigationController?.pushViewController(birthdayVC, animated: true)
                }
            }
        }
    }
}

// MARK: - Textfield Delegate
extension PhoneConfirmationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text?.count ?? 0 < 1,
           string.count > 0 {
            switch textField {
            case textField1:
                textField2.becomeFirstResponder()
            case textField2:
                textField3.becomeFirstResponder()
            case textField3:
                textField4.becomeFirstResponder()
            case textField4:
                logInButton.becomeFirstResponder()
            default:
                break
            }

            textField.text = string
            confirmationCode += string
            return false
            
        } else if textField.text?.count ?? 0 >= 1,
                  string.count == 0 {
            
            switch textField {
            case textField1:
                textField1.becomeFirstResponder()
            case textField2:
                textField1.becomeFirstResponder()
            case textField3:
                textField2.becomeFirstResponder()
            case textField4:
                textField3.becomeFirstResponder()
            default:
                break
            }
            
            textField.text = ""
            return false
        
        } else if textField.text?.count ?? 0 >= 1 {
            textField.text = string
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        checkCode()
        return true
    }
}
