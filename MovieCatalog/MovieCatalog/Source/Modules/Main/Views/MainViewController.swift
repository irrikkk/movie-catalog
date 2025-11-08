//
//  MainViewController.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 16.10.2025.
//

import UIKit

class MainViewController : UIViewController {
    private let cellIdentifier = "MovieCell"
    private var movies: [MovieModel] = []
    
    private let tableView = UITableView ()
    private let headerView = MainHeaderView()
    private let viewModel = MainViewModel()
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bindToViewModel()
        viewModel.getMovies()
        
        view.backgroundColor = .black

    }
    
    private func bindToViewModel() {
        viewModel.onDidLoadMovies = { [weak self] moviesData in
            self?.headerView.configure(with: .init(mainFilmPoster: moviesData.headerImage, films: []))
            self?.movies = moviesData.movies
            self?.tableView.reloadData()
        }
    }
    
    private func setup() {
        setupTableView()
        setupHeaderView()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        tableView.backgroundColor = .black
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MovieCell.self, forCellReuseIdentifier: cellIdentifier)
    }
    
    private func setupHeaderView() {
        let headerHeight: CGFloat = 500
        
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: headerHeight)
        
        tableView.tableHeaderView = headerView
        
        headerView.layoutIfNeeded()
        
        let size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            tableView.tableHeaderView = headerView
        }
        
    }
        
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieCell else {
            return UITableViewCell()
            
        }
            
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        cell.backgroundColor = .black
        cell.contentView.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}

class MovieCell: UITableViewCell {
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let yearLabel = UILabel()
    private let countryLabel = UILabel()
    private let genresLabel = UILabel()
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .black
        contentView.backgroundColor = .black
            
        
        titleLabel.textColor = .white
        yearLabel.textColor = .white
        countryLabel.textColor = .white
        genresLabel.textColor = .white
        
        contentView.addSubview(posterImageView)
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = 8
        posterImageView.backgroundColor = .systemGray5
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = UIFont(name: "IBMPlexSans-Bold", size: 20)
        titleLabel.numberOfLines = 2
        
        contentView.addSubview(yearLabel)
        yearLabel.translatesAutoresizingMaskIntoConstraints = false
        yearLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        yearLabel.textColor = .white
        
        
        contentView.addSubview(countryLabel)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        countryLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        countryLabel.textColor = .white
        
        contentView.addSubview(genresLabel)
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresLabel.font = UIFont(name: "IBMPlexSans-Regular", size: 14)
        genresLabel.textColor = .white
        genresLabel.numberOfLines = 2
        
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            posterImageView.widthAnchor.constraint(equalToConstant: 100),
            posterImageView.heightAnchor.constraint(equalToConstant: 144),
            
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            yearLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            yearLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            
            countryLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            countryLabel.topAnchor.constraint(equalTo: yearLabel.bottomAnchor, constant: 4),
            
            genresLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            genresLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            genresLabel.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 4),
            genresLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
            
        ])
        
    }
    
    func configure(with movie: MovieModel) {
        titleLabel.text = movie.title
        yearLabel.text = "\(movie.year)"
        countryLabel.text = "\(movie.country)"
        genresLabel.text = "\(movie.genres.joined(separator: ", "))"
        
        if let url = URL(string: movie.poster) {
            posterImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "film"))
        }
    }
}




