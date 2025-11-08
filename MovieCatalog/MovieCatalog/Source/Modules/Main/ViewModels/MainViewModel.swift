//
//  MainViewModel.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 06.11.2025.
//

import Foundation

class MainViewModel {
    private let networkService = NetworkService.shared
    
    var onDidLoadMovies: ((MainFilmsModel) -> Void)?
    
    private var page = 1
    
    func getMovies() {
        networkService.getMovies(page: page) { [weak self] result in
            switch result {
            case .success(let moviesResponse):
                self?.handleSuccessRequest(moviesResponse)
            case .failure(let error):
                print("Error loading movies: \(error)")
            }
        }
    }
    
    private func handleSuccessRequest(_ result: MoviesPagedListModel) {
        var resultMovies = result.movies
        
        guard !resultMovies.isEmpty else {
            print("No movies available")
            return
        }
        
        let header = resultMovies.remove(at: 0)
        
        let moviesModel = MainFilmsModel(
            headerId: header.id,
            headerImage: header.poster,
            favorites: [],
            movies: resultMovies.map { movie in
                MovieModel(
                    id: movie.id,
                    title: movie.name,
                    poster: movie.poster,
                    year: movie.year,
                    country: movie.country,
                    genres: movie.genres.map { $0.name }
                )
            }
        )
        
        DispatchQueue.main.async {
            self.onDidLoadMovies?(moviesModel)
        }
    }
}

