//
//  RegistrationButton.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 3/11/21.
//

import UIKit

class RegistrationButton: UIButton {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.backgroundColor = Colors.orange.color
        return indicator
    }()
    
    public var isLoading: Bool = false {
        didSet {
            if isLoading {
                self.alpha = 0.6
                activityIndicator.startAnimating()
            } else {
                self.alpha = 1
                activityIndicator.stopAnimating()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        self.layer.cornerRadius = 25
        self.backgroundColor = Colors.orange.color
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUp() {
        addSubview(activityIndicator)
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private var isInvertButton = false {
        didSet {
            if isInvertButton {
                self.titleLabel?.textColor = Colors.gray.color
                self.backgroundColor = Colors.background.color
            } else {
                self.titleLabel?.textColor = .white
                self.backgroundColor = Colors.orange.color
            }
        }
    }
    
    func isInvert() {
        isInvertButton = true
    }
    
    func setTitle(_ text: String) {
        setTitle(text, for: .normal)
    }
}
