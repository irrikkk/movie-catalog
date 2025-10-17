//
//  MainViewController.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 16.10.2025.
//

import UIKit

class MainViewController : UIViewController {
    private var headerImageView: UIImageView!
    private var watchButton: UIButton!
    private var favoriteLabel: UILabel!
    private var favoritesCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setupHeader()
        setupFavoriteLabel()
        setupFavoriteCollection()
        setupConstraints()
        
    }
        
    func setupHeader() {
        headerImageView = UIImageView()
        headerImageView.contentMode = .scaleAspectFill
        
        // заглушка
        setupImagePlaceholder()
            
        watchButton = UIButton(type: .system)
        watchButton.setTitle("Смотреть", for: .normal)
        watchButton.titleLabel?.font = UIFont(name: "IBMPlexSans-Medium", size: 16)
        watchButton.backgroundColor = UIColor(named: "AccentColor")
        watchButton.setTitleColor(.white, for: .normal)
        watchButton.layer.cornerRadius = 4
        watchButton.addTarget(self, action: #selector(watchButtonTapped), for: .touchUpInside)
            
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        watchButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerImageView)
        view.addSubview(watchButton)
            
    
    }
    
    func setupFavoriteLabel() {
        favoriteLabel = UILabel()
        favoriteLabel.text = "Избранное"
        favoriteLabel.font = UIFont(name: "IBMPlexSans-Bold", size: 24)
        favoriteLabel.textColor = UIColor(named: "AccentColor")
        favoriteLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(favoriteLabel)
        
    }
    
    func setupFavoriteCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        favoritesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        favoritesCollectionView.backgroundColor = .clear
        favoritesCollectionView.showsHorizontalScrollIndicator = false
        favoritesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
//        favoritesCollectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
//        
//        favoritesCollectionView.delegate = self
//        favoritesCollectionView.dataSource = self
//        
        view.addSubview(favoritesCollectionView)
    
    }
    
    func setupImagePlaceholder() {
        let config = UIImage.SymbolConfiguration(pointSize: 40, weight: .light)
        headerImageView.image = UIImage(systemName: "film", withConfiguration: config)
        headerImageView.tintColor = .lightGray
    }
    
    private func setupConstraints() {
        headerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        headerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        headerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        headerImageView.heightAnchor.constraint(equalTo: headerImageView.widthAnchor, multiplier: 400/375).isActive = true
        
        watchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 249).isActive = true
        watchButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 108).isActive = true
        watchButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -107).isActive = true
        watchButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        favoriteLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 32).isActive = true
        favoriteLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor ,constant: 16).isActive = true
        favoriteLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -230).isActive = true
        
        
        favoritesCollectionView.topAnchor.constraint(equalTo: favoriteLabel.bottomAnchor, constant: 8).isActive = true
        favoritesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        favoritesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive =  true
        favoritesCollectionView.heightAnchor.constraint(equalToConstant: 144).isActive = true
        
    }
    
    @objc func watchButtonTapped() {
        print("кнопка Смотреть нажата")
    }
    
   
}




