//
//  MainModel.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 06.11.2025.
//

import Foundation

struct MoviesPagedListModel: Codable {
    let movies: [MovieElementModel]
    let pageInfo: PageInfo
}

struct MovieElementModel: Codable {
    let id: String
    let name: String
    let poster: String
    let year: Int
    let country: String
    let genres: [GenreModel]
    let reviews:[ReviewShortModel]
    
}

struct GenreModel: Codable {
    let id: String
    let name: String
}

struct ReviewShortModel: Codable {
    let id: String
    let rating: Int
    
}

struct PageInfo: Codable {
    let pageSize: Int
    let pageCount: Int
    let currentPage: Int
}

struct MainFilmsModel {
    let headerId: String
    let headerImage: String
    let favorites: [FavoriteModel]
    let movies: [MovieModel]
}

struct FavoriteModel {
    let id: String
    let poster: String
}

struct MovieModel {
    let id: String
    let title: String
    let poster: String
    let year: Int
    let country: String
    let genres: [String]
}
