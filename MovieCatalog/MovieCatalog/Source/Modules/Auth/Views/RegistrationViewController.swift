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

    // MARK: - ScrollView
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let viewModel = RegistrationViewModel()

    // MARK: - Error Labels
    private let usernameErrorLabel = createErrorLabel()
    private let emailErrorLabel = createErrorLabel()
    private let nameErrorLabel = createErrorLabel()
    private let passwordErrorLabel = createErrorLabel()
    private let confirmPasswordErrorLabel = createErrorLabel()

    private static func createErrorLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .red
        label.font = UIFont(name: "IBMPlexSans-Medium", size: 10)
        label.isHidden = true
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }

    private let textFieldStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    var logoStartFrame: CGRect?
    var logoSnapshot: UIView?

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

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        setupUIStack()
        setupDatePicker()
        setupHaveAccountButton()
        setupRegisterButton()
        setupConstraints()
        setupErrorLabels()
        setupErrorLabelsConstraints()
        setupConnectionWithViewModel()
        setupTextFieldActions()
        setupCloseKeyboard()
    }


    // MARK: - logo


    @objc func showCenteredDatePicker() {

        let datePickerVC = UIViewController()
        datePickerVC.modalPresentationStyle = .overCurrentContext
        datePickerVC.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        let containerView = UIView()
        containerView.backgroundColor = UIColor.gray
        containerView.layer.cornerRadius = 12
        containerView.layer.masksToBounds = true
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.tag = 123

        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.date = selectedDate
        datePicker.maximumDate = Date()
        datePicker.preferredDatePickerStyle = .inline

        datePicker.backgroundColor = .clear


        datePicker.tintColor = UIColor(named: "AccentColor")
        datePicker.setValue(UIColor(named: "AccentColor"), forKey: "textColor")

        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)

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
        genderSegmentedControl.insertSegment(withTitle: "Мужчина", at: 0, animated: false)
        genderSegmentedControl.insertSegment(withTitle: "Женщина", at: 1, animated: false)

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
        genderSegmentedControl.heightAnchor.constraint(equalToConstant: 36).isActive = true

        textFieldStackView.addArrangedSubview(genderSegmentedControl)
    }

    // MARK: - RegisterButton
    func setupRegisterButton() {
        registerButton = UIButton(type: .system)
        registerButton.setTitle("Зарегистрироваться ", for: .normal)
        registerButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        registerButton.backgroundColor = .black
        registerButton.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        registerButton.layer.borderWidth = 1
        registerButton.layer.cornerRadius = 4
        registerButton.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor

        registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)

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

        haveAccountButton.addTarget(self, action: #selector(haveAccountButtonTapped), for: .touchUpInside)

        haveAccountButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(haveAccountButton)

        NSLayoutConstraint.activate([
            haveAccountButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16),
            haveAccountButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -16),
            haveAccountButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -6),

            haveAccountButton.heightAnchor.constraint(equalToConstant: 32),
        ])

    }

    // MARK: - Animation Logo
    func animateLogoFrom(logoSnapshot: UIView) {
        guard let startFrame = logoStartFrame else { return }

        let finalFrame = imageViewLogo.convert(imageViewLogo.bounds, to: view)

        logoSnapshot.frame = startFrame
        view.addSubview(logoSnapshot)

        imageViewLogo.isHidden = true

        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            logoSnapshot.frame = finalFrame
        }) { _ in
            self.imageViewLogo.isHidden = false
            logoSnapshot.removeFromSuperview()
        }
    }


    // MARK: - Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: registrationLabel.bottomAnchor, constant: 16),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -44),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            textFieldStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            textFieldStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textFieldStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textFieldStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    // MARK: Error labels View
    private func setupErrorLabels() {
        let errorLabels = [usernameErrorLabel, emailErrorLabel, nameErrorLabel,
                           passwordErrorLabel, confirmPasswordErrorLabel]

        errorLabels.forEach { view.addSubview($0) }
    }

    private func setupErrorLabelsConstraints() {
        let fieldErrorPairs: [(UITextField, UILabel)] = [
            (textFieldLogin, usernameErrorLabel),
            (textFieldEmail, emailErrorLabel),
            (textFieldName, nameErrorLabel),
            (textFieldPassword, passwordErrorLabel),
            (textFieldConfirmPassword, confirmPasswordErrorLabel)
        ]

        for (textField, errorLabel) in fieldErrorPairs {
            NSLayoutConstraint.activate([
                errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 1),
                errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
                errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
            ])
        }
    }

    // MARK: - TextField Actions
    private func setupTextFieldActions() {
        textFieldLogin.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        textFieldEmail.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        textFieldName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        textFieldPassword.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        textFieldConfirmPassword.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }

    // MARK: - UI Update
    private func updateValidationMessage() {
        usernameErrorLabel.text = viewModel.loginValidationMessage
        emailErrorLabel.text = viewModel.emailValidationMessage
        nameErrorLabel.text = viewModel.nameValidationMessage
        passwordErrorLabel.text = viewModel.passwordValidationMessage
        confirmPasswordErrorLabel.text = viewModel.confirmPasswordValidationMessage

        usernameErrorLabel.isHidden = viewModel.loginValidationMessage.isEmpty
        emailErrorLabel.isHidden = viewModel.emailValidationMessage.isEmpty
        nameErrorLabel.isHidden = viewModel.nameValidationMessage.isEmpty
        passwordErrorLabel.isHidden = viewModel.passwordValidationMessage.isEmpty
        confirmPasswordErrorLabel.isHidden = viewModel.confirmPasswordValidationMessage.isEmpty
    }

    private func updateRegisterButton(isEnabled: Bool) {
        registerButton.isEnabled = isEnabled

        if isEnabled {
            registerButton.backgroundColor = UIColor(named: "AccentColor")
            registerButton.setTitleColor(.white, for: .normal)
            registerButton.layer.borderColor = UIColor(named: "AccentColor")?.cgColor
        } else {
            registerButton.backgroundColor = .black
            registerButton.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
            registerButton.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        }
    }

    private func handleRegistrationSuccess() {
        dismiss(animated: true) {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let mainViewController = MainTabBarViewController()
                sceneDelegate.window?.rootViewController = mainViewController
            }
        }
    }

    // MARK: - Actions
    @objc private func textFieldChanged() {
        viewModel.login = textFieldLogin.text ?? ""
        viewModel.email = textFieldEmail.text ?? ""
        viewModel.name = textFieldName.text ?? ""
        viewModel.password = textFieldPassword.text ?? ""
        viewModel.confirmPassword = textFieldConfirmPassword.text ?? ""
    }

    @objc private func registerButtonTapped() {
        view.endEditing(true)
        viewModel.performRegistration()
    }

    @objc func haveAccountButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    @objc func dateChanged(_ sender: UIDatePicker) {
        selectedDate = sender.date
        viewModel.birthDate = sender.date

        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        formatter.locale = Locale(identifier: "ru_RU")
        textFieldDateOfBirth.text = formatter.string(from: selectedDate)

        dismiss(animated: true, completion: nil)
    }

    @objc func genderChanged(_ sender: UISegmentedControl) {
        selectedGender = sender.selectedSegmentIndex
        viewModel.gender = sender.selectedSegmentIndex
    }

    @objc func setupCloseKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    // MARK: - ViewModel
    private func setupConnectionWithViewModel() {
        viewModel.onFormValidation = { [weak self] isValid in
            self?.updateRegisterButton(isEnabled: isValid)
        }
        viewModel.onValidationMessageUpdate = { [weak self]  in
            self?.updateValidationMessage()
        }
        viewModel.onRegistrationSuccess = { [weak self] in
            self?.handleRegistrationSuccess()
        }

    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
        case textFieldLogin:
            viewModel.wasLoginChanged = true
        case textFieldEmail:
            viewModel.wasEmailChanged = true
        case textFieldName:
            viewModel.wasNameChanged = true
        case textFieldPassword:
            viewModel.wasPasswordChanged = true
        case textFieldConfirmPassword:
            viewModel.wasConfirmPasswordChanged = true
        default:
            break
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case textFieldLogin:
            textFieldEmail.becomeFirstResponder()
        case textFieldEmail:
            textFieldName.becomeFirstResponder()
        case textFieldName:
            textFieldPassword.becomeFirstResponder()
        case textFieldPassword:
            textFieldConfirmPassword.becomeFirstResponder()
        case textFieldConfirmPassword:
            textFieldConfirmPassword.resignFirstResponder()
        default :
            textField.resignFirstResponder()

        }
        return true
    }
}

private extension RegistrationViewController {
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

        contentView.addSubview(textFieldStackView)
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

        if textField == textFieldPassword || textField == textFieldConfirmPassword {
            textField.isSecureTextEntry = true
            textField.textContentType = .newPassword
        }

        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 44))
        textField.leftView = paddingView
        textField.leftViewMode = .always

        if textField == textFieldConfirmPassword {
            textField.returnKeyType = .done
        } else {
            textField.returnKeyType = .next
        }

        textField.delegate = self

        if textField == textFieldDateOfBirth {
            let calendarImageView = UIImageView(image: UIImage(systemName: "calendar"))
            calendarImageView.tintColor = UIColor(named: "GrayFadedMyColor")
            calendarImageView.contentMode = .scaleAspectFit

            let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            calendarImageView.frame = CGRect(x: 10, y: 13, width: 18, height: 18)
            rightView.addSubview(calendarImageView)

            textField.rightView = rightView
            textField.rightViewMode = .always

        }

        textField.translatesAutoresizingMaskIntoConstraints = false
        textFieldStackView.addArrangedSubview(textField)

        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }

    // MARK: - DatePicker

    func setupDatePicker() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showCenteredDatePicker))
        textFieldDateOfBirth.addGestureRecognizer(tapGesture)
    }
}



