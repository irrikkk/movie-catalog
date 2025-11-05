//
//  ViewController.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 09.10.2025.
//

import UIKit

class SignInViewController: UIViewController {
    // MARK: - UI Elements
    let imageViewLogo = UIImageView(image: UIImage(named: "logoApp"))
    let textFieldViewLogin = UITextField()
    let textFieldViewPassword = UITextField()
    let buttonSignIn = UIButton(type: .custom)
    let buttonRegistration = UIButton(type: .custom)
    
    private let viewModel = SignInViewModel()
    
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
        
        
        textFieldViewLogin.attributedPlaceholder = NSAttributedString(
            string: "Логин",
            attributes: [
                .foregroundColor: UIColor(named: "GrayFadedMyColor")!,
                .font: UIFont(name: "IBMPlexSans-Regular", size: 14)!
            ])
        
        let paddingView1 = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textFieldViewLogin.leftView = paddingView1
        textFieldViewLogin.leftViewMode = .always
        
        textFieldViewLogin.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        textFieldViewLogin.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textFieldViewLogin)
        
        
        
        // MARK: - Input2
        textFieldViewPassword.textColor = UIColor(named: "AccentColor")
        textFieldViewPassword.borderStyle = .none
        textFieldViewPassword.layer.borderWidth = 1
        textFieldViewPassword.layer.cornerRadius = 8
        textFieldViewPassword.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        textFieldViewPassword.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        
        textFieldViewPassword.attributedPlaceholder = NSAttributedString(
            string: "Пароль",
            attributes: [
                .foregroundColor: UIColor(named: "GrayFadedMyColor")!,
                .font: UIFont(name: "IBMPlexSans-Regular", size: 14)!
            ])
        
        let paddingView2 = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textFieldViewPassword.leftView = paddingView2
        textFieldViewPassword.leftViewMode = .always
        
        textFieldViewPassword.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        textFieldViewPassword.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textFieldViewPassword)
        
        
        
        // MARK: - Button1
        buttonSignIn.setTitle("Войти", for: .normal)
        buttonSignIn.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        buttonSignIn.backgroundColor = .black
        buttonSignIn.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        buttonSignIn.layer.borderWidth = 1
        buttonSignIn.layer.cornerRadius = 4
        buttonSignIn.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        
        buttonSignIn.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        
        buttonSignIn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonSignIn)
        
        
        // MARK: - Button2
        buttonRegistration.setTitle("Регистрация", for: .normal)
        buttonRegistration.backgroundColor = .black
        buttonRegistration.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        buttonRegistration.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        
        buttonRegistration.addTarget(self, action: #selector(registrationButtonTapped), for: .touchUpInside)
        
        buttonRegistration.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonRegistration)
        
        setupConstraints()
        setupConnectionWithViewModel()
        
    }
    
    // MARK: - Constraints
    private func setupConstraints() {
       NSLayoutConstraint.activate([
            imageViewLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            imageViewLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 250/375),
            imageViewLogo.heightAnchor.constraint(equalTo: imageViewLogo.widthAnchor, multiplier: 169.59/250),
      
            textFieldViewLogin.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16),
            textFieldViewLogin.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            textFieldViewLogin.topAnchor.constraint(equalTo: imageViewLogo.bottomAnchor, constant: 96),
            textFieldViewLogin.heightAnchor.constraint(equalToConstant: 44),
        
            textFieldViewPassword.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16),
            textFieldViewPassword.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            textFieldViewPassword.topAnchor.constraint(equalTo: textFieldViewLogin.bottomAnchor, constant: 16),
            textFieldViewPassword.heightAnchor.constraint(equalToConstant: 44),
            
            buttonSignIn.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16),
            buttonSignIn.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            buttonSignIn.bottomAnchor.constraint(equalTo: buttonRegistration.topAnchor, constant: -8),
            buttonSignIn.heightAnchor.constraint(equalToConstant: 44),
            
            buttonRegistration.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16),
            buttonRegistration.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            buttonRegistration.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
            buttonRegistration.heightAnchor.constraint(equalToConstant: 32),
            
            
        ])
    }
    
    // MARK: - UI Update
    private func updateLoginButton(isEnabled: Bool) {
        buttonSignIn.isEnabled = isEnabled
        if isEnabled {
            buttonSignIn.backgroundColor = UIColor(named: "AccentColor")
            buttonSignIn.setTitleColor(.white, for: .normal)
            buttonSignIn.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        } else {
            buttonSignIn.backgroundColor = .black
            buttonSignIn.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
            buttonSignIn.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        }
    }
    
    // MARK: - Sign In
    private func handleLoginSuccess() {
       
    }
    
        
    // MARK: - Actions
    @objc private func textFieldDidChange() {
        viewModel.login = textFieldViewLogin.text ?? ""
        viewModel.password = textFieldViewPassword.text ?? ""
        
        viewModel.onFormValidation?(viewModel.isFormValid)

    }
    
    @objc func signInButtonTapped() {
        view.endEditing(true)
        viewModel.performLogin()
    }
        
    
    @objc func registrationButtonTapped() {
        let registrationViewController = RegistrationViewController()
        registrationViewController.modalPresentationStyle = .fullScreen
        
        // MARK: - Animation
        registrationViewController.logoStartFrame = imageViewLogo.convert(imageViewLogo.bounds, to: nil)
            
        let logoSnapshot = imageViewLogo.snapshotView(afterScreenUpdates: false)!
        logoSnapshot.frame = imageViewLogo.convert(imageViewLogo.bounds, to: view)
        view.addSubview(logoSnapshot)
            
        imageViewLogo.isHidden = true
            
        
        self.present(registrationViewController, animated: false) {
            registrationViewController.animateLogoFrom(logoSnapshot: logoSnapshot)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        imageViewLogo.isHidden = false
    }
        
}

// MARK: - ViewModel
extension SignInViewController { 
    private func setupConnectionWithViewModel() {
        viewModel.onFormValidation = { [weak self] isValid in
            print("форма валидна \(isValid)")
            self?.updateLoginButton(isEnabled: isValid)
        }
        
        viewModel.onLoginSuccess = { [weak self] in
            print("успешный вход")
            self?.handleLoginSuccess()
        }
        
    }
    
}


