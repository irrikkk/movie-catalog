//
//  RegistrationViewController.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 23.10.2025.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    // MARK: - UI Elements
    private var imageViewLogo: UIImageView!
    private var registrationLabel: UILabel!
    private var datePicker: UIDatePicker!
    private var genderSegmentedControl = UISegmentedControl()
    private var registerButton: UIButton!
    private var haveAccountButton: UIButton!
    
    private let textFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Input Fields
    private let textFieldLogin = UITextField()
    private let textFieldEmail = UITextField()
    private let textFieldName = UITextField()
    private let textFieldPassword = UITextField()
    private let textFieldConfirmPassword = UITextField()
    private let textFieldDateOfBirth =  UITextField()

    
    private var selectedDate = Date()
    private var selectedGender: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupImageViewLogo()
        setupRegistrationLabel()
        setupUIStack()
        setupDatePicker()
        setupHaveAccountButton()
        setupRegisterButton()
        setupConstraints()
    }

    
    // MARK: - logo
    func setupImageViewLogo() {
        imageViewLogo = UIImageView(image: UIImage(named: "logoApp"))
        imageViewLogo.contentMode = .scaleAspectFit
        imageViewLogo.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(imageViewLogo)
        
        NSLayoutConstraint.activate([
            imageViewLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageViewLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            imageViewLogo.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 147.41/375),
            imageViewLogo.heightAnchor.constraint(equalTo: imageViewLogo.widthAnchor, multiplier: 100/147.41)
        ])
        
    }
    
    func setupRegistrationLabel() {
        registrationLabel = UILabel()
        registrationLabel.text = "Регистрация"
        registrationLabel.font = UIFont(name: "IBMPlexSans-Bold", size: 24)
        registrationLabel.textColor = UIColor(named: "AccentColor")
        registrationLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(registrationLabel)
        
        NSLayoutConstraint.activate([
            registrationLabel.topAnchor.constraint(equalTo: imageViewLogo.bottomAnchor, constant: 24),
            registrationLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 19),
            registrationLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -13),
        ])
    }
    
    // MARK: - TextField
    func setupUIStack() {
        setupTextField(textFieldLogin, placeholder: "Логин")
        setupTextField(textFieldEmail, placeholder: "Email")
        setupTextField(textFieldName, placeholder: "Имя")
        setupTextField(textFieldPassword, placeholder: "Пароль")
        setupTextField(textFieldConfirmPassword, placeholder: "Подтвердите пароль")
        setupTextField(textFieldDateOfBirth, placeholder: "Дата рождения")
        setupGenderSegmentedControl()
        
        view.addSubview(textFieldStackView)
    }
    
    func setupTextField(_ textField: UITextField, placeholder: String) {
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "GrayFadedMyColor")!,
            .font: UIFont(name: "IBMPlexSans-Regular", size: 14)!
        ]
            textField.attributedPlaceholder = NSAttributedString(
                string: placeholder,
                attributes: placeholderAttributes
        )
        
        textField.textColor = UIColor(named: "AccentColor")
        textField.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        textField.borderStyle = .none
        
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 8
        textField.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        if textField == textFieldDateOfBirth {
            let calendarImageView = UIImageView(image: UIImage(systemName: "calendar"))
            calendarImageView.tintColor = UIColor(named: "GrayFadedMyColor")
            calendarImageView.contentMode = .scaleAspectFit
            
            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            calendarImageView.frame = CGRect(x: 10, y: 13, width: 18, height: 18)
            rightView.addSubview(calendarImageView)
            
            textField.rightView = rightView
            textField.rightViewMode = .always
            
            //textField.delegate = self
            
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textFieldStackView.addArrangedSubview(textField)
        
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
    
    func setupDatePicker() {
        // MARK: - DatePicker
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCenteredDatePicker))
        textFieldDateOfBirth.addGestureRecognizer(tapGesture)
    }
    
    @objc func showCenteredDatePicker() {
        
        let datePickerVC = UIViewController()
        datePickerVC.modalPresentationStyle = .overCurrentContext
        datePickerVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        let containerView = UIView()
        containerView.backgroundColor = UIColor.gray
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.date = selectedDate
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .inline
        
        datePicker.backgroundColor = .clear
        
       
        datePicker.tintColor = UIColor(named: "AccentColor")
        datePicker.setValue(UIColor(named: "AccentColor"), forKey: "textColor")
        
        
        datePicker.addTarget(self, action: #selector(dateSelectedAutomatically(_:)), for: .valueChanged)
        

        datePicker.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(datePicker)
        datePickerVC.view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: datePickerVC.view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: datePickerVC.view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 375),
            containerView.heightAnchor.constraint(equalToConstant: 413),
            
            datePicker.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10),
            datePicker.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
            datePicker.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10),
            datePicker.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10),
        ])
        
        present(datePickerVC, animated: true, completion: nil)
       
    }
    
    // MARK: - GenderControle
    func setupGenderSegmentedControl() {
        genderSegmentedControl.insertSegment(withTitle: "Мужской", at: 0, animated: false)
        genderSegmentedControl.insertSegment(withTitle: "Женский", at: 1, animated: false)
        
        genderSegmentedControl.selectedSegmentTintColor = UIColor(named: "AccentColor")
        genderSegmentedControl.backgroundColor = .black
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "IBMPlexSans-Regular", size: 14)!,
            .foregroundColor: UIColor(named: "GrayFadedMyColor")!
        ]
        
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "IBMPlexSans-Regular", size: 14)!,
            .foregroundColor: UIColor(named: "GrayFadedMyColor")!
        ]
        
        genderSegmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        genderSegmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        genderSegmentedControl.layer.borderWidth = 1
        genderSegmentedControl.layer.cornerRadius = 8
        genderSegmentedControl.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        
        genderSegmentedControl.addTarget(self, action: #selector(genderChanged(_:)), for: .valueChanged)
        
        genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        genderSegmentedControl.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        textFieldStackView.addArrangedSubview(genderSegmentedControl)
    }
    
    // MARK: - RegisterButton
    func setupRegisterButton() {
        registerButton = UIButton(type: .system)
        registerButton.setTitle("Зарегестрироваться ", for: .normal)
        registerButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        registerButton.backgroundColor = .black
        registerButton.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 4
        registerButton.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            registerButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16),
            registerButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            registerButton.bottomAnchor.constraint(equalTo: haveAccountButton.topAnchor, constant: -8),
            
            registerButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
    
    // MARK: - HaveAccountButton
    func setupHaveAccountButton() {
        haveAccountButton = UIButton(type: .system)
        haveAccountButton.setTitle("У меня уже есть аккаунт", for: .normal)
        haveAccountButton.backgroundColor = .black
        haveAccountButton.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        haveAccountButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        
        haveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(haveAccountButton)
        
        NSLayoutConstraint.activate([
            haveAccountButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16),
            haveAccountButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            haveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),
                
            haveAccountButton.heightAnchor.constraint(equalToConstant: 32),
        ])
            
    }
    
    
    // MARK: - Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            textFieldStackView.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 16),
            textFieldStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textFieldStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
        ])
    }
    
    // MARK: - Date Picker Actions
    @objc func dateSelectedAutomatically(_ sender: UIDatePicker) {
        selectedDate = sender.date
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        textFieldDateOfBirth.text = formatter.string(from: selectedDate)
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func genderChanged(_ sender: UISegmentedControl) {
        selectedGender = sender.selectedSegmentIndex
    }
    
}
