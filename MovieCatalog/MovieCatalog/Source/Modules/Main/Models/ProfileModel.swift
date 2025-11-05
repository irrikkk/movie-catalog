//
//  ProfileModel.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 03.11.2025.
//

import Foundation

struct ProfileResponse: Codable {
    let id: String
    let nickName: String
    let email: String
    let avatarLink: String?
    let name: String
    let birthDate: String
    let gender: Int
}


