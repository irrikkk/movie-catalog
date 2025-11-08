//
//  MainHeaderView.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 06.11.2025.
//

import UIKit
import Kingfisher

class MainHeaderView: UIView {
    struct Config {
        let mainFilmPoster: String
        let films: [String]
    }
    
    private let imageView = UIImageView()
    private let gradient = CAGradientLayer()
    private let watchButton = UIButton()
        
    private let favoritesTitle = UILabel()
    private let favoritesCollection = UIView()
    
    convenience init() {
        self.init(frame: .zero)
        setup()
    }
    
    func configure(with config: Config) {
        guard let urlImage = URL(string: config.mainFilmPoster) else { return }
        imageView.kf.setImage(with: urlImage)
    }
    
    private func setup() {
        backgroundColor = .black
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .darkGray
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 600)
        ])
        
    }
}
