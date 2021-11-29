//
//  ProfileEditViewController.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 10/11/21.
//

import UIKit

class ProfileEditViewController: BaseViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.text = "Редактирование"
        return label
    }()
    
    private lazy var nameTextField: RegistrationTextField = {
        let field = RegistrationTextField()
        field.setPlaceholder(with: "Ramazan", color: .gray)
        field.setImage(with: Icons.Registration.user.name)
        field.setBorderColor(with: .clear)
        field.setBackgroundColor(with: Colors.gray.color)
        field.setKeyboardType(with: .default)
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return field
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
    
    private lazy var birthdayTextField: RegistrationTextField = {
        let field = RegistrationTextField()
        field.setPlaceholder(with: "21.12.12", color: .gray)
        field.setImage(with: Icons.Registration.calendar.name)
        field.setBorderColor(with: .clear)
        field.setBackgroundColor(with: Colors.gray.color)
        field.setKeyboardType(with: .numberPad)
        field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return field
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.backgroundColor = Colors.orange.color
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(saveProfileInfo), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        
        return indicator
    }()
    
    // MARK: - Injection
    var viewModel: ProfileViewModelType!
    
    private var isLoading = false {
        didSet {
            if isLoading {
                activityIndicator.startAnimating()
                saveButton.alpha = 0.5
                saveButton.isEnabled = false
            }
            activityIndicator.stopAnimating()
            saveButton.alpha = 1
            saveButton.isEnabled = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
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
        view.addSubview(nameTextField)
        view.addSubview(phoneTextField)
        view.addSubview(birthdayTextField)
        view.addSubview(saveButton)
        saveButton.addSubview(activityIndicator)
    }
    
    private func setUpConstaints () {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        phoneTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        birthdayTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(birthdayTextField.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.width.equalTo(30)
        }
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        
    }
    
    @objc
    private func saveProfileInfo() {
        isLoading = true
//        editProfile()
        guard let nameText = nameTextField.text else { return }
        viewModel.editProfile(userName: nameText, birthDate: "f") { [weak self] res in
            if case .success() = res {
                self?.changesDone()
            } else if case .failure(let err) = res {
                print(err.localizedDescription)
            }
        }
    }
    
    private func editProfile() {
        guard let nameText = nameTextField.text
//              let birthDatText = birthdayTextField.text
        else { return }
        
        let editProfileCompletion = { [unowned self] completion in
            viewModel.editProfile(userName: nameText, birthDate: "f", completion: completion)
        }
        
        withRetry(editProfileCompletion) { [weak self] res in
            if case .success() = res {
                self?.changesDone()
            } else if case .failure(let err) = res {
                print(err.localizedDescription)
            }
        }
    }
    
    private func changesDone() {
        let alert = UIAlertController(
            title: "Изменения не сохранены",
            message: "Хотите покинуть страницу редактирования?",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Да", style: .default))
        alert.addAction(UIAlertAction(title: "Нет", style: .default))
        present(alert, animated: true)
    }
}
