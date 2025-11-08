//
//  NetworkService.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 31.10.2025.
//

import Alamofire
import Foundation

class NetworkService {
    static let shared = NetworkService()
    
    private let baseURL = "https://react-midterm.kreosoft.space/api"
    
    // MARK: - Headers
    private var headers: HTTPHeaders {
        var headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        if let token = TokenManager.shared.authToken {
            headers["Authorization"] = "Bearer \(token)"
        }
        
        return headers
    }
    
    // MARK: - Registration
    func register(registerRequest: RegisterRequest, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        
        AF.request(
            "\(baseURL)/account/register",
            method: .post,
            parameters: registerRequest,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: RegisterResponse.self) { response in
            switch response.result {
            case .success(let registerResponse):
                completion(.success(registerResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - Login
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, Error>) -> Void) {
        let loginReuest = LoginRequest(username: username, password: password)
        
        AF.request(
            "\(baseURL)/account/login",
            method: .post,
            parameters: loginReuest,
            encoder: JSONParameterEncoder.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: LoginResponse.self) { response in
            switch response.result {
            case .success(let loginResponse):
                completion(.success(loginResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    // MARK: - User
    func getProfile(completion: @escaping (Result<ProfileResponse, Error>) -> Void) {
        AF.request (
            "\(baseURL)/account/profile",
            method: .get,
            headers: headers
        )
        .validate()
        .responseDecodable(of: ProfileResponse.self) { response in
            switch response.result {
            case .success(let profileResponse):
                completion(.success(profileResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    //MARK: - Movies
    func getMovies(page: Int, completion: @escaping (Result<MoviesPagedListModel, Error>) -> Void) {
        print("Making request to: \(baseURL)/movies/\(page)")
        
        AF.request(
            "\(baseURL)/movies/\(page)",
            method: .get,
            headers: headers
        )
        .validate()
        .responseDecodable(of: MoviesPagedListModel.self) { response in
            switch response.result {
            case .success(let moviesResponse):
                print("Successfully received \(moviesResponse.movies.count) movies")
                completion(.success(moviesResponse))
            case .failure(let error):
                print("Error loading movies: \(error)")
                completion(.failure(error))
            }
        }
    }
}
