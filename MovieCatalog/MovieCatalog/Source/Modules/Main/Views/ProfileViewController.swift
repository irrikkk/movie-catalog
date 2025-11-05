//
//  ProfileViewController.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 16.10.2025.
//

import UIKit

class ProfileViewController : UIViewController {
    // MARK: - UI Elements
    private var profileHeaderStackView: UIStackView!
    private var avatarImageView: UIImageView!
    private var nameLabel: UILabel!
    private var segmentedControl: UISegmentedControl!
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private var logautButton: UIButton!
    
    // MARK: - Info Items
    private let emailContainer = UIView()
    private let nameContainer = UIView()
    private let dateOfBirthContainer = UIView()
    private let genderContainer = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        setupProfileHeader()
        setupInfoStack()
        setupLogoutButton()
        setupConstraints()
    }
    
    // MARK: - Profile Header
    func setupProfileHeader() {
        profileHeaderStackView = UIStackView()
        profileHeaderStackView.axis = .horizontal
        profileHeaderStackView.spacing = 16
        profileHeaderStackView.alignment = .center
        profileHeaderStackView.backgroundColor = .black
        profileHeaderStackView.translatesAutoresizingMaskIntoConstraints = false
        
        avatarImageView = UIImageView(image: UIImage(systemName: "person.circle.fill"))
        avatarImageView.contentMode = .scaleAspectFill
        avatarImageView.layer.cornerRadius = 40
        avatarImageView.clipsToBounds = true
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel = UILabel()
        nameLabel.text = "Тест" // пока без API
        nameLabel.font = UIFont(name: "SFProText-Bold", size: 24)
        nameLabel.textColor = .white
        
        profileHeaderStackView.addArrangedSubview(avatarImageView)
        profileHeaderStackView.addArrangedSubview(nameLabel)
        
        view.addSubview(profileHeaderStackView)
        
    }
    
    // MARK: - Info Stack
    func setupInfoStack() {
        setupInfoItem(title: "E-mail", value: "test@example.com")
        setupInfoItem(title: "Имя", value: "Тест Тестович")
        setupInfoItem(title: "Дата рождения", value: "01.01.2022")
        setupGenderItem()
        
        view.addSubview(infoStackView)
    }
    
    func setupInfoItem(title: String, value: String) {
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        titleLabel.textColor = UIColor(named: "GrayMyColor")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let valueField = UIView()
        valueField.backgroundColor = .black
        valueField.layer.borderWidth = 1
        valueField.layer.cornerRadius = 8
        valueField.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
        valueField.translatesAutoresizingMaskIntoConstraints = false
        
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        valueLabel.textColor = UIColor(named: "AccentColor")
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        valueField.addSubview(valueLabel)
        
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 8
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(valueField)
        
        NSLayoutConstraint.activate([
            valueField.heightAnchor.constraint(equalToConstant: 44),
            valueLabel.centerYAnchor.constraint(equalTo: valueField.centerYAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: valueField.leadingAnchor, constant: 16),
            valueLabel.trailingAnchor.constraint(equalTo: valueField.trailingAnchor, constant: -16)
        ])
        
        infoStackView.addArrangedSubview(container)
        
    }
    // MARK: - Segmented Control
    func setupGenderItem() {
        let titleLabel = UILabel()
        titleLabel.text = "Пол"
        titleLabel.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        titleLabel.textColor = UIColor(named: "GrayMyColor")
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedControl = UISegmentedControl()
        segmentedControl.insertSegment(withTitle: "Мужчина", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "Женщина", at: 1, animated: false)
        segmentedControl.selectedSegmentIndex = 1
        segmentedControl.selectedSegmentTintColor = UIColor(named: "AccentColor")
        segmentedControl.backgroundColor = .black
        segmentedControl.isUserInteractionEnabled = false
            
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "IBMPlexSans-Regular", size: 14)!,
            .foregroundColor: UIColor(named: "GrayFadedMyColor")!
        ]
            
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(name: "IBMPlexSans-Regular", size: 14)!,
            .foregroundColor: UIColor(named: "GrayFadedMyColor")!
        ]
            
        segmentedControl.setTitleTextAttributes(normalAttributes, for: .normal)
        segmentedControl.setTitleTextAttributes(selectedAttributes, for: .selected)
        segmentedControl.layer.borderWidth = 1
        segmentedControl.layer.cornerRadius = 8
        segmentedControl.layer.borderColor = UIColor(named: "GrayMyColor")?.cgColor
            
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 8
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.heightAnchor.constraint(equalToConstant: 36),
            
        ])
        infoStackView.addArrangedSubview(container)
    }
    
    // MARK: - Logaut Button
    func setupLogoutButton() {
        logautButton = UIButton(type: .system)
        logautButton.setTitle("Выйти из аккаунта", for: .normal)
        logautButton.backgroundColor = .black
        logautButton.setTitleColor(UIColor(named: "AccentColor"), for: .normal)
        logautButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        
        //logautButton.addTarget(self, action: #selector(logautButtonTapped), for: .touchUpInside)
        
        logautButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logautButton)
    }
   
    // MARK: - Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileHeaderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileHeaderStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 88/375),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 88/88),
            
            infoStackView.topAnchor.constraint(equalTo: profileHeaderStackView.bottomAnchor, constant: 32),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

        
            logautButton.leadingAnchor.constraint(equalTo: view.leadingAnchor ,constant: 16),
            logautButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            logautButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            logautButton.heightAnchor.constraint(equalToConstant: 32),
            
        ])
    }
}

