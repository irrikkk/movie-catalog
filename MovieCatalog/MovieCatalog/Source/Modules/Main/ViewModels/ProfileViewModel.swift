//
//  ProfileViewModel.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 03.11.2025.
//

import Foundation


class ProfileViewModel {
    // MARK: - Properties
    private(set) var profile: ProfileResponse?
    
    // MARK: - Callbacks
    var onProfileLoaded: (() -> Void)?
    var onLoadingStateChanged: ((Bool) -> Void)?
    var onError: ((String) -> Void)?
    var onLogoutSuccess: (() -> Void)?
    
    // Load Profile
    func loadProfile() {
        NetworkService.shared.getProfile { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let profile):
                    self?.profile = profile
                    self?.onProfileLoaded?()
                case .failure(let error):
                    if let afError = error.asAFError {
                        let responseCode = afError.responseCode
                        if responseCode == 401 {
                            TokenManager.shared.authToken = nil
                            self?.onError?("Сессия истекла, необходимо войти снова")
                        } else {
                            self?.onError?("Ошибка загрузки профиля")
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Logout
    func performLogout() {
        TokenManager.shared.authToken = nil
        onLogoutSuccess?()
    }
}
