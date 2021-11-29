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
    
    private lazy var birthDateField: RegistrationTextField = {
        let field = RegistrationTextField()
        field.setPlaceholder(with: "01.01.1991", color: .gray)
        field.setImage(with: Icons.Registration.calendar.name)
        field.setBorderColor(with: .clear)
        field.setBackgroundColor(with: Colors.gray.color)
        field.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
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
    var viewModel: PhoneRegistrationViewModelType!
    
    private var bDayDate: Date?
    
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
    }
    
    private func setUpSubviews() {
        view.addSubview(registrationLabel)
        view.addSubview(textLabel)
        view.addSubview(birthDateField)
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
        birthDateField.snp.makeConstraints { make in
            make.top.equalTo(textLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(60)
        }
        getCodeButton.snp.makeConstraints { make in
            make.top.equalTo(birthDateField.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(56)
        }
    }
    
    @objc
    private func getCodeButtonTapped() {
//        guard let bDay = bDayDate else { return }
//        let formatter1 = DateFormatter()
//        formatter1.dateStyle = .full
//        formatter1.string(from: bDay)
//        let birthday = BirthdayDTO(bdate: "\(bDay)")
//        setBirthdayToUser(bDate: birthday)
        let baseVC = BaseTabViewController()
        baseVC.modalPresentationStyle = .overFullScreen
        present(baseVC, animated: true)
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        
    }
    
    @objc
    private func doneButtonPressed() {
        if let datePicker = birthDateField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            birthDateField.text = dateFormatter.string(from: datePicker.date)
            bDayDate = datePicker.date
        }
        birthDateField.resignFirstResponder()
     }
    
    private func setBirthdayToUser(bDate: BirthdayDTO) {
        let birthdayCompletion = { [unowned self] completion in
            viewModel.setBirthdayToUser(userBDay: bDate, completion: completion)
        }
        let baseVC = BaseTabViewController()
        withRetry(birthdayCompletion) { [weak self] res in
            if case .success = res {
                self?.present(baseVC, animated: true)
            }
        }
    }
}
