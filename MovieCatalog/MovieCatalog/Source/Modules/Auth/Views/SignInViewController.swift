//
//  ViewController.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 09.10.2025.
//

import UIKit

class SignInViewController: UIViewController {
    var onLoginSuccess: (() -> Void)?
    
    // MARK: - UI Elements
    let imageViewLogo = UIImageView(image: UIImage(named: "logoApp"))
    let textFieldViewLogin = UITextField()
    let textFieldViewPassword = UITextField()
    let buttonSignIn = UIButton(type: .system)
    let buttonRegistration = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // MARK: - logo
        imageViewLogo.contentMode = .scaleAspectFit
        imageViewLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageViewLogo)
        
        
        // MARK: - Input1
        textFieldViewLogin.textColor = UIColor(named: "AccentColor")
        textFieldViewLogin.borderStyle = .none
        textFieldViewLogin.layer.borderWidth = 1
        textFieldViewLogin.layer.cornerRadius = 8
        textFieldViewLogin.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        textFieldViewLogin.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        
        let paragraphStyleLogin = NSMutableParagraphStyle()
        paragraphStyleLogin.firstLineHeadIndent = 16
        
        textFieldViewLogin.attributedPlaceholder = NSAttributedString(string: "Логин",
                                                                      attributes: [
                                                                        .foregroundColor: UIColor(named: "GrayFadedMyColor")!,
                                                                        .paragraphStyle: paragraphStyleLogin,
                                                                        .font: UIFont(name: "IBMPlexSans-Regular", size: 14)!
                                                                      ])
        
        textFieldViewLogin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textFieldViewLogin)
        
        
        
        // MARK: - Input2
        textFieldViewPassword.textColor = UIColor(named: "AccentColor")
        textFieldViewPassword.borderStyle = .none
        textFieldViewPassword.layer.borderWidth = 1
        textFieldViewPassword.layer.cornerRadius = 8
        textFieldViewPassword.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        textFieldViewPassword.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        
        let paragraphStyleRegistration = NSMutableParagraphStyle()
        paragraphStyleRegistration.firstLineHeadIndent = 16
        
        textFieldViewPassword.attributedPlaceholder = NSAttributedString(string: "Пароль",
        attributes: [
            .foregroundColor: UIColor(named: "GrayFadedMyColor")!,
            .paragraphStyle: paragraphStyleRegistration,
            .font: UIFont(name: "IBMPlexSans-Regular", size: 14)!
        ])
        
        textFieldViewPassword.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textFieldViewPassword)
        
        
        
        // MARK: - Button1
        buttonSignIn.setTitle("Войти", for: .normal)
        buttonSignIn.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        buttonSignIn.backgroundColor = UIColor(named: "BlackMyColor")
        buttonSignIn.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        buttonSignIn.layer.borderWidth = 1
        buttonSignIn.layer.cornerRadius = 4
        buttonSignIn.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        buttonSignIn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonSignIn)
        
        buttonSignIn.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        
        // MARK: - Button2
        buttonRegistration.setTitle("Регистрация", for: .normal)
        buttonRegistration.backgroundColor = UIColor(named: "BlackMyColor")
        buttonRegistration.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        buttonRegistration.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        
        buttonRegistration.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonRegistration)
        
        buttonRegistration.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        
        
        setupConstraints()
        setupDelegates()
        updateLoginButtonState()
    }
    
    private func setupDelegates() {
        textFieldViewLogin.delegate = self
        textFieldViewPassword.delegate = self
        
        // отслежка изменений текста
        textFieldViewLogin.addTarget(self, action: #selector(textFieldDidChange ), for: .editingChanged)
        textFieldViewPassword.addTarget(self, action: #selector(textFieldDidChange ), for: .editingChanged)
        
        
    }
    
    // MARK: - Layout Constraints
    private func setupConstraints() {
       
        imageViewLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageViewLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
            
        imageViewLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 250/375).isActive = true
        imageViewLogo.heightAnchor.constraint(equalTo: imageViewLogo.widthAnchor, multiplier: 169.59/250).isActive = true
  
        
    
        textFieldViewLogin.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 19).isActive = true
        textFieldViewLogin.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -13).isActive = true
        textFieldViewLogin.topAnchor.constraint(equalTo: imageViewLogo.bottomAnchor, constant: 96).isActive = true
            
        textFieldViewLogin.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
    
        textFieldViewPassword.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 19).isActive = true
        textFieldViewPassword.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -13).isActive = true
        textFieldViewPassword.topAnchor.constraint(equalTo: textFieldViewLogin.bottomAnchor, constant: 16).isActive = true
            
        textFieldViewPassword.heightAnchor.constraint(equalToConstant: 44).isActive = true
      
        
        
        buttonSignIn.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16).isActive = true
        buttonSignIn.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        buttonSignIn.bottomAnchor.constraint(equalTo: buttonRegistration.topAnchor, constant: -8).isActive = true
        
            
        buttonSignIn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
      
        buttonRegistration.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16).isActive = true
        buttonRegistration.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        buttonRegistration.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
            
        buttonRegistration.heightAnchor.constraint(equalToConstant: 32).isActive = true
       
    }
    
    // MARK: - Action Methods
    @objc func  textFieldDidChange() {
        updateLoginButtonState()
    }
    
    @objc func signInButtonTapped() {
        view.endEditing(true)
        
        UserDefaults.standard.set(true, forKey: "isUserSignedIn")
        navigateToMainScreen()
        
    }
    
    @objc func registrationButtonTapped() {
        UserDefaults.standard.set(false, forKey: "isUserSignedIn")
        navigateToMainScreen()
    }
    
    func navigateToMainScreen() {
        onLoginSuccess?()
    }
    
    func updateLoginButtonState() {
        let login = textFieldViewLogin.text ?? ""
        let password = textFieldViewPassword.text ?? ""
        
        let isEnabled = !login.isEmpty && !password.isEmpty
        
        buttonSignIn.isEnabled = isEnabled
        
        if isEnabled {
            buttonSignIn.backgroundColor = UIColor(named: "AccentColor")
            buttonSignIn.setTitleColor(.white, for: .normal)
            
        } else {
            buttonSignIn.backgroundColor = .blackMy
            buttonSignIn.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
            buttonSignIn.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        }
    }
}

// MARK: - UITextFieldDelegate
extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textFieldViewLogin:
            textFieldViewPassword.becomeFirstResponder()
        case textFieldViewPassword:
            textFieldViewPassword.resignFirstResponder()
            
            if buttonSignIn.isEnabled {
                signInButtonTapped()
            }
        default :
            break
        }
        
        return true
        
    }
}
