//
//  ViewController.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 09.10.2025.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: UI Elements
    let imageViewLogo = UIImageView(image: UIImage(named: "logoApp"))
    let textFieldViewLogin = UITextField()
    let textFieldViewPassword = UITextField()
    let buttonViewSignIn = UIButton(type: .system)
    let buttonViewRegistration = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        // MARK: logo
        imageViewLogo.contentMode = .scaleAspectFit
        imageViewLogo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageViewLogo)
    
        
        // MARK: Input1
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

        
        
        // MARK: Input2
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

        
        
        // MARK: Button1
        buttonViewSignIn.setTitle("Войти", for: .normal)
        buttonViewSignIn.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        buttonViewSignIn.backgroundColor = UIColor(named: "BlackMyColor")
        buttonViewSignIn.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        buttonViewSignIn.layer.borderWidth = 1
        buttonViewSignIn.layer.cornerRadius = 4
        buttonViewSignIn.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        buttonViewSignIn.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonViewSignIn)
        
     
        
        // MARK: Button2
        buttonViewRegistration.setTitle("Регистрация", for: .normal)
        buttonViewRegistration.backgroundColor = UIColor(named: "BlackMyColor")
        buttonViewRegistration.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        buttonViewRegistration.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        
        buttonViewRegistration.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonViewRegistration)
        
        setupConstraints()
        
       
        
    }
    
    // MARK: Layout Constraints
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
      
        
        
        buttonViewSignIn.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16).isActive = true
        buttonViewSignIn.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        buttonViewSignIn.bottomAnchor.constraint(equalTo: buttonViewRegistration.topAnchor, constant: -8).isActive = true
        
            
        buttonViewSignIn.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        
      
        buttonViewRegistration.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16).isActive = true
        buttonViewRegistration.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        buttonViewRegistration.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6).isActive = true
            
        buttonViewRegistration.heightAnchor.constraint(equalToConstant: 32).isActive = true
       
    }

}
