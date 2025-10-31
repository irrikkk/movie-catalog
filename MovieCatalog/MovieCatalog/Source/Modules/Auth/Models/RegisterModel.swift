//
//  RegisterModel.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 31.10.2025.
//

import Foundation

struct RegisterRequest: Codable {
    let userName: String
    let name: String
    let password: String
    let email: String
    let birthDate: String
    let gender: Int
}

struct RegisterResponse: Codable {
    let token: String
}
