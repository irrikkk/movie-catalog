//
//  SignInViewModel.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 30.10.2025.
//

import Foundation

class SignInViewModel {
    // MARK: - Input Properties
    var login: String = ""
    var password: String = ""
    
    
    var isFormValid: Bool {
        return !login.isEmpty && !password.isEmpty
    }

    // MARK: - Callbacks
    var onFormValidation: ((Bool) -> Void)?
    var onLoginSuccess: (() -> Void)?
    var onLoginError: ((String) -> Void)? 
    
    // MARK: - Login Logic
    func performLogin() {
        // отправляем запрос входа
        NetworkService.shared.login(username: login, password: password) { [weak self] result in
            
            switch result {
            case .success(let loginResponse):
                // сохраняем токен
                TokenManager.shared.authToken = loginResponse.token
                self?.onLoginSuccess?()
            case .failure(let error):
                print("ошибка входа: \(error.localizedDescription)")
                self?.onLoginError?(error.localizedDescription)
            }
        }
    }
}
