//
//  RegistrationViewModel.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 31.10.2025.
//

import Foundation

class RegistrationViewModel {
    // MARK: - Input Properties
    var login: String = "" {
        didSet {
            validateForm()
        }
    }
    
    var email: String = "" {
        didSet {
            validateForm()
        }
    }
    
    var name: String = "" {
        didSet {
            validateForm()
        }
    }
    
    var password: String = "" {
        didSet {
            validateForm()
        }
    }
    
    var confirmPassword: String = "" {
        didSet {
            validateForm()
        }
    }
    
    var birthDate: Date = Date()
    
    var gender: Int = 0

    
    // MARK: - Validation State
    private(set) var isLoginValid: Bool = false
    private(set) var isEmailValid: Bool = false
    private(set) var isNameValid: Bool = false
    private(set) var isPasswordlValid: Bool = false
    private(set) var isConfirmPasswordValid: Bool = false
    private var isFormValid: Bool = false {
        didSet {
            onFormValidation?(isFormValid)
        }
    }
    
    // MARK: - Validation Message
    var loginValidationMessage: String = ""
    var emailValidationMessage: String = ""
    var nameValidationMessage: String = ""
    var passwordValidationMessage: String = ""
    var confirmPasswordValidationMessage: String = ""
    
    // MARK: - Callbacks
    var onFormValidation: ((Bool) -> Void)?
    var onValidationMessageUpdate: (() -> Void)?
    var onRegistrationSuccess: (() -> Void)?
    var onRegisrrationError: ((String) -> Void)?
    
    // MARK: - Validation Logic
    private func validateForm() {
        isLoginValid = !login.isEmpty
        loginValidationMessage = isLoginValid ? "" : "Введите логин"
        
        isEmailValid = !email.isEmpty && email.isValidEmail()
        if email.isEmpty {
            emailValidationMessage = "Введите email"
        } else if !email.isValidEmail() {
            emailValidationMessage = "Введите корректный email"
        } else {
            emailValidationMessage = ""
        }
        
        isNameValid = !name.isEmpty
        nameValidationMessage = isNameValid ? "" : "Введите имя"
        
        isPasswordlValid = !password.isEmpty
        passwordValidationMessage = isPasswordlValid ? "" : "Введите пароль"
        
        isConfirmPasswordValid = !confirmPassword.isEmpty && password == confirmPassword
        if confirmPassword.isEmpty {
            confirmPasswordValidationMessage = "Повторите пароль"
        } else if password != confirmPassword {
            confirmPasswordValidationMessage = "Пароли не совпадают"
        } else {
            confirmPasswordValidationMessage = ""
        }
            isFormValid = isLoginValid && isEmailValid && isNameValid && isPasswordlValid && isConfirmPasswordValid
            
            onValidationMessageUpdate?()
            
    }
    
    // MARK: - Registration Logic
    func performRegistration() {
        // отправляем запрос регистрации
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        let birthDateString = dateFormatter.string(from: birthDate)
        
        let registerRequest = RegisterRequest (
            userName: login,
            name: name,
            password: password,
            email: email,
            birthDate: birthDateString,
            gender: gender
        )
        
        NetworkService.shared.register(registerRequest: registerRequest) { [weak self] result in
            switch result {
            case .success(let registerResponse):
                // сохраняем токен и автоматически логиним пользователя
                TokenManager.shared.authToken = registerResponse.token
                self?.onRegistrationSuccess?()
            case .failure(let error):
                self?.onRegisrrationError?(error.localizedDescription)
            }
        }
    }
}
