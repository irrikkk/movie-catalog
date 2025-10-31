//
//  TokenManager.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 30.10.2025.
//

import KeychainSwift

class TokenManager {
    static let shared = TokenManager()
    private let keychain = KeychainSwift()
    
    private let tokenKey = "userAuthToken"
    private let tokenExpiryKey = "tokenExpiryDate"
    
    var authToken: String? {
        get { return keychain.get(tokenKey) }
        set {
            if let token = newValue {
                keychain.set(token, forKey: tokenKey)
            } else {
                keychain.delete(tokenKey)
                keychain.delete(tokenExpiryKey)
            }
                
        }
        
    }
    
}
