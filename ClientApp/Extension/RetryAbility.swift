//
//  RetryAbility.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 4/11/21.
//

import UIKit

typealias Completion<ResultType, ErrorType: Error> = (Result<ResultType, ErrorType>) -> Void
typealias Retryable<ResultType, ErrorType: Error> = (@escaping Completion<ResultType, ErrorType>) -> Void

extension UIViewController {
    
    func withRetry<ResultType, ErrorType: Error>(
        _ operation: @escaping Retryable<ResultType, ErrorType>,
        completion: @escaping Completion<ResultType, ErrorType>
    ) {
        
        operation { [weak self] res in
            switch res {
            case .success:
                completion(res)
            case .failure(let err):
                if err.localizedDescription.contains("The Internet connection appears to be offline") || err.localizedDescription.contains("connection is not currently allowed") {
                    print(err.localizedDescription)
                }
                
                if let self = self {
                    self.retryAfter(error: err, retry: {
                        self.withRetry(operation, completion: completion)
                    }, cancel: {
                        completion(res)
                    })
                } else {
                    completion(res)
                }
            }
        }
    }
    
    func retryAfter(error: Error, retry: @escaping () -> Void, cancel: @escaping () -> Void = { }) {
        
        let errorTitle = "Error"
        let errorMessage = error.localizedDescription

        let alert = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        alert.view.tintColor = Asset.clientBackround.color
        
        let retryAction = UIAlertAction(
            title: "Retry",
            style: .default) { (_) in
                retry()
        }
        
        let cancelAction = UIAlertAction(
            title: "Cancel",
            style: .cancel) { (_) in
                cancel()
        }
        
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        
        alert.view.tintColor = .black
        present(alert, animated: true) { [unowned alert] in
            alert.view.tintColor = .black
        }
    }
}

protocol NameDescribable {
    var typeName: String { get }
    static var typeName: String { get }
}

extension NameDescribable {
    var typeName: String {
        return String(describing: type(of: self))
    }

    static var typeName: String {
        return String(describing: self)
    }
}

extension NSObject: NameDescribable {}
