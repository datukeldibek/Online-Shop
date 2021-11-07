//
//  StorageService.swift
//  ClientApp
//
//  Created by Рамазан Юсупов on 4/11/21.
//

import Foundation

enum StorageKey: String {
    case userRegistered
    case userLoggedIn
    case onboardingShowedUp
    case currentUser
    case notificationSettings
    case orderTypes
    case selectedMoods
    case priceLevels
    case soundIsOn
    case allowingPushRequested
    case uploadHintsShowed
    case mainFeedHintsShowed
    case profileHintsShowed
    case dateOfLogActicateApp
    case forbiddenToShowVenuePlaceholder
    case mainFeedItems
}

protocol KeyValueStoreType {
    func removeValue(forKey key: StorageKey)
    func string(forKey key: StorageKey) -> String?
    func data(forKey key: StorageKey) -> Data?
    func bool(forKey key: StorageKey) -> Bool
    
    func set(_ value: String?, forKey key: StorageKey)
    func set(_ value: Data?, forKey key: StorageKey)
    func set(_ value: Bool?, forKey key: StorageKey)
    
    func clear()
}

extension UserDefaults: KeyValueStoreType {
    
    func removeValue(forKey key: StorageKey) {
        removeObject(forKey: key.rawValue)
    }
    
    func string(forKey key: StorageKey) -> String? {
        return string(forKey: key.rawValue)
    }
    
    func data(forKey key: StorageKey) -> Data? {
        return data(forKey: key.rawValue)
    }
    
    func bool(forKey key: StorageKey) -> Bool {
        return bool(forKey: key.rawValue)
    }
    
    func set(_ value: String?, forKey key: StorageKey) {
        set(value, forKey: key.rawValue)
    }
    
    func set(_ value: Data?, forKey key: StorageKey) {
        set(value, forKey: key.rawValue)
    }
    
    func set(_ value: Bool?, forKey key: StorageKey) {
        set(value, forKey: key.rawValue)
    }
    
    func clear() {
        self.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
    }

}

class TransientStorageService: KeyValueStoreType {
    
    static let shared = TransientStorageService()
    
    private init() {}
    
    private var store = [StorageKey: Any]()
    
    func removeValue(forKey key: StorageKey) {
        store[key] = nil
    }
    
    func string(forKey key: StorageKey) -> String? {
        return store[key] as? String
    }
    
    func data(forKey key: StorageKey) -> Data? {
        return store[key] as? Data
    }
    
    func bool(forKey key: StorageKey) -> Bool {
        return store[key] as? Bool ?? false
    }
    
    func set(_ value: String?, forKey key: StorageKey) {
        store[key] = value
    }
    
    func set(_ value: Data?, forKey key: StorageKey) {
        store[key] = value
    }
    
    func set(_ value: Bool?, forKey key: StorageKey) {
        store[key] = value
    }
    
    func clear() {
        store = [StorageKey: Any]()
    }
}
