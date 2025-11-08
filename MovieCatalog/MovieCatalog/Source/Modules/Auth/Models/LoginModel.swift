//
//  LoginModel.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 31.10.2025.
//

import Foundation

struct LoginRequest: Codable {
    let username: String
    let password: String    
}

struct LoginResponse: Codable {
    let token : String
}
