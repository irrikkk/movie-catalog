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
    
    private var infoStackView: UIStackView!
//    private var emailField: ProfileInfoField!
//    private var nameField: ProfileInfoField!
//    private var dateOfBirthField: ProfileInfoField!
//    private var genderField: ProfileInfoField!
    private var logautButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupProfileHeader()
        setupInfoStack()
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
        nameLabel.text = "Новикова Ирина" // пока без API
        nameLabel.font = UIFont(name: "SFProText-Bold", size: 24)
        nameLabel.textColor = .white
        
        profileHeaderStackView.addArrangedSubview(avatarImageView)
        profileHeaderStackView.addArrangedSubview(nameLabel)
        
        view.addSubview(profileHeaderStackView)
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 88/375),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor, multiplier: 88/88)
        ])
    }
    
    // MARK: - Info Stack
    func setupInfoStack() {
        infoStackView = UIStackView()
        infoStackView.axis = .vertical
        infoStackView.spacing = 12
        infoStackView.backgroundColor = .black
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        
//        emailField = ProfileInfoField()
//        emailField.configure(title: "Email", value: "pupupu@gmail.com")
//
//        nameField = ProfileInfoField()
//        nameField.configure(title: "Имя", value: "Новикова Ирина")
//        
//        dateOfBirthField = ProfileInfoField()
//        dateOfBirthField.configure(title: "Дата рождения", value: "1995-07-22")
        
        let genderContainer = UIView()
        genderContainer.backgroundColor = .black
        
        
    }
    
    // MARK: - Constraints
    func setupConstraints() {
        NSLayoutConstraint.activate([
            profileHeaderStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            profileHeaderStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileHeaderStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}
