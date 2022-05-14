//
//  AuthService.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 3/11/21.
//

import Foundation
import KeychainAccess
import Alamofire

protocol AuthServiceType: RequestInterceptor {
    var isAuthorizing: Bool { get }
    var isAuthorized: Bool { get }
    
    func logout()
    // MARK: - Registration
    func registerViaPhone(user: RegistrationDTO, completion: @escaping (Result<Void, Error>) -> Void)
    func sendConfirmation(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<JwtInfo, Error>) -> Void)
    
    // MARK: - Authorization
    func authorizeUser(user: AuthorizationDTO, completion: @escaping (Result<Void, Error>) -> Void)
    func confirmAuthCode(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<JwtInfo, Error>) -> Void)
}

class AuthService: NSObject, AuthServiceType {

    enum SignInResult: Hashable {
        case authorized
    }
    
    enum AuthError: String, Error {
        case tokenExpired
    }
    
    private var webApi: WebApiServiceType!
    private var currentToken: JwtInfo?
    private let keychain: Keychain = Keychain()
    private var keyValueStore: KeyValueStoreType
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    
    private let lock = NSLock()
    private var requestsToRetry: [(RetryResult) -> Void] = []
    
    let tokenKey = "client.app.neocafe"
    
    var isAuthorized: Bool {
        guard let token = currentToken else { return false }
        return !token.jwtTokenExpired
    }
    
    private(set) var isAuthorizing: Bool = false
    
    init(keyValueStore: KeyValueStoreType) {
        self.keyValueStore = keyValueStore
        super.init()
        self.configure()
        
    }
    
    func setWebService(_ webApi: WebApiServiceType) {
        self.webApi = webApi
    }
    
    func configure() {
        if let data = try? keychain.getData(tokenKey),
           let token = try? decoder.decode(JwtInfo.self, from: data) {
            self.currentToken = token
        } else {
            try? keychain.remove(tokenKey)
        }
    }
    
    // MARK: - Registration
    func registerViaPhone(user: RegistrationDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        webApi.registerNewUser(user: user, completion: completion)
    }
    
    func sendConfirmation(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<JwtInfo, Error>) -> Void) {
        webApi.sendConfirmation(for: phoneNumber, confirmationCode: confirmationCode) { [weak self] res in
            self?.handleAuthResult(res, completion: completion)
        }
    }
    
    // MARK: - Authorization
    func authorizeUser(user: AuthorizationDTO, completion: @escaping (Result<Void, Error>) -> Void) {
        webApi.authorizeUser(phoneNumber: user, completion: completion)
    }
    
    func confirmAuthCode(for phoneNumber: String, confirmationCode: String, completion: @escaping (Result<JwtInfo, Error>) -> Void) {
        webApi.confirmAuthCode(for: phoneNumber, confirmationCode: confirmationCode) { [weak self] res in
            self?.handleAuthResult(res, completion: completion)
        }
    }
    
    // MARK: - Refreshing Token
    func refreshToken(completion: @escaping (Result<JwtInfo, Error>) -> Void) {
        
        guard let token = currentToken else {
            logout()
            return
        }
        print(token)
        isAuthorizing = true
        
//        webApi.refresh(token: token.refreshToken) { (res) in
//            defer { self.isAuthorizing = false }
//
//            switch res {
//            case .success(let token):
//                do {
//                    try self.saveToken(token)
//                    completion(.success(self.currentUser!))
//                } catch {
//                    completion(.failure(error))
//                }
//            case .failure(let err):
//                self.logout()
//                completion(.failure(err))
//            }
//        }
    }
    
    private func handleAuthResult(_ result: Result<JwtInfo, Error>, completion: (Result<JwtInfo, Error>) -> Void) {
        if case .success(let response) = result {
            do {
                try self.saveToken(response)
                completion(.success(response))
            } catch {
                completion(.failure(error))
            }
        } else {
            print("error")
        }
    }
    
    private func handleRegistration(_ res: Result<JwtInfo, Error>, completion: (Result<JwtInfo, Error>) -> Void) {
        if case .success(let authInfo) = res {
            do {
                try self.saveToken(authInfo)
                completion(.success(authInfo))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    private func saveToken(_ t: JwtInfo) throws {
        self.currentToken = t
        let data = try encoder.encode(t)
        try keychain.set(data, key: tokenKey)
    }
    
    func logout() {
        currentToken = nil
        try? keychain.remove(tokenKey)
        
        keyValueStore.removeValue(forKey: .currentUser)
        keyValueStore.removeValue(forKey: .userLoggedIn)
    }

    // MARK: - RequestAdapter
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        // If access token is expired, fast-fail the request with expiration error, RequestRetrier implementation will handle it further
        // Note: refresh token expiration is not handled since it is not logically possible to have refresh token expired at this point
        guard let accessToken = currentToken?.jwt else {
            completion(.failure(AuthError.tokenExpired))
            return
        }
        var adaptedRequest = urlRequest

        adaptedRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        completion(.success(adaptedRequest))
    }
    
    // MARK: - RequestRetrier
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        lock.lock()
        defer { lock.unlock() }
        
        if let afError = error as? AFError,
            case .requestAdaptationFailed(let adaptionError) = afError,
            let authError = adaptionError as? AuthError,
            authError == .tokenExpired {
            
            requestsToRetry.append(completion)
            
            completion(.doNotRetry)
        }
    }
}
