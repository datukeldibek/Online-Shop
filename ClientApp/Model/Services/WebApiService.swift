//
//  WebApiService.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 3/11/21.
//

import Foundation
import Alamofire

protocol WebApiServiceType {
    // MARK: - Registration
    func registerNewUser(user: RegistrationDTO, completion: @escaping (Result<Void, Error>) -> Void)
    func sendConfirmation(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<Void, Error>) -> Void)
    
    // MARK: - Authorization
    func authorizeUser(phoneNumber number: AuthorizationDTO, completion: @escaping (Result<Void, Error>) -> Void)
    func confirmAuthCode(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<JwtInfo, Error>) -> Void)
    
    // MARK: - Person editing
    func setBirthdayToUser(userBDay: BirthdayDTO, completion: @escaping (Result<BirthdayDTO, Error>) -> Void)
}

class WebApiService: WebApiServiceType {
    
    private static func urlSessionConfig() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        
        configuration.httpAdditionalHeaders = [:]
        configuration.httpAdditionalHeaders?["Accept"] = "application/json"
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.timeoutIntervalForRequest = 20
        
        return configuration
    }
    
    internal let encoder: JSONEncoder = JSONEncoder()
    internal let decoder: JSONDecoder = JSONDecoder()
    internal let dateFormatter: DateFormatter = DateFormatter()
    internal let afSession: Session = Session(configuration: WebApiService.urlSessionConfig())
    internal let authService: AuthServiceType = AuthService.shared
    
    static let shared = WebApiService()
    
    private  init() {}
    
    // MARK: - Handler
    func handleResponse<T: Decodable>(of type: T.Type, response: DataResponse<T, AFError>, completion: @escaping (Result<T, Error>) -> Void) {
        switch response.result {
        case .success(let t):
            completion(.success(t))
        case .failure(let err):
            completion(.failure(self.handleError(data: response.data, error: err)))
        }
    }
    
    func handleEmptyResponse(response: DataResponse<Data?, AFError>, completion: @escaping (Result<Void, Error>) -> Void) {
        switch response.result {
        case .success:
            completion(.success(()))
        case .failure(let err):
            completion(.failure(handleError(data: response.data, error: err)))
        }
    }
    
    private func handleError(data d: Data?, error: Error) -> Error {
        print(">>>>> Error: code \((error as? AFError)?.responseCode ?? 0), message: \(error.localizedDescription)")
        if let data = d, let message = String(data: data, encoding: .utf8) {
            print(">>>>> Error message: \(message)")
            return error
        } else {
            return error
        }
    }
    
    // MARK: - Registration
    
    func registerNewUser(user: RegistrationDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        afSession.request(
            CommonConstants.Registration.registerUser(),
                method: .post,
                parameters: RegistrationDTO(firstName: user.firstName, phoneNumber: user.phoneNumber),
                encoder: JSONParameterEncoder.default
            )
        .validate()
        .response { [weak self] (response) in
            self?.handleEmptyResponse(response: response, completion: completion)
        }
    }
    
    func sendConfirmation(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<Void, Error>) -> Void) {
        afSession.request(
            CommonConstants.Registration.confirmCode(),
            method: .post,
            parameters: [
                "code": confirmationCode,
                "phoneNumber": phoneNumber
            ],
            encoder: JSONParameterEncoder.default
        )
        .validate()
        .response { [weak self] (response) in
            self?.handleEmptyResponse(response: response, completion: completion)
        }
    }
    
    // MARK: - Authorization
    func authorizeUser(phoneNumber number: AuthorizationDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        afSession.request(
            CommonConstants.Authorization.authorizeUser(),
            method: .post,
            parameters: AuthorizationDTO(phoneNumber: number.phoneNumber),
            encoder: JSONParameterEncoder.default
        )
            .validate()
            .response { [weak self] (response) in
                self?.handleEmptyResponse(response: response, completion: completion)
            }
    }
    
    func confirmAuthCode(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<JwtInfo, Error>) -> Void) {
        afSession.request(
            CommonConstants.Authorization.confirmAuthorizationCode(),
            method: .post,
            parameters: [
                "code": confirmationCode,
                "phoneNumber": phoneNumber
            ],
            encoder: JSONParameterEncoder.default
        )
            .validate()
            .responseDecodable { [weak self] (response) in
                self?.handleResponse(of: JwtInfo.self, response: response, completion: completion)
            }
    }
    
    // MARK: - Profile Editing
    func setBirthdayToUser(userBDay: BirthdayDTO, completion: @escaping (Result<BirthdayDTO, Error>) -> Void) {
        afSession.request(
            CommonConstants.ProfileEditing.setBirthdayToUser(),
            method: .put,
            parameters: userBDay,
            encoder: JSONParameterEncoder.default
        )
            .validate()
            .responseDecodable { [weak self] (response) in
                self?.handleResponse(of: BirthdayDTO.self, response: response, completion: completion)
            }
    }
}
