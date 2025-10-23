//
//  MainTapBarController.swift
//  MovieCatalog
//
//  Created by Ирина Новикова on 16.10.2025.
//

import UIKit


class MainTabBarViewController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        
        if let font = UIFont(name: "IBMPlexSans-Medium", size: 14) {
            let titleOffset = UIOffset(horizontal: 0, vertical: 10)
           
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.font: font]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.font: font]
            
            appearance.stackedLayoutAppearance.normal.titlePositionAdjustment = titleOffset
            appearance.stackedLayoutAppearance.selected.titlePositionAdjustment = titleOffset
           
        }
        
        tabBar.standardAppearance = appearance
       
        if #available(iOS 15.0, *) {
                tabBar.scrollEdgeAppearance = appearance
        }
        
    }
    
    private func setupViewControllers() {
        
        let mainVC = MainViewController()
        let collectionVC = CollectionViewController()
        let profileVC = ProfileViewController()
        
        let mainNavVC = UINavigationController(rootViewController: mainVC)
        let collectionNavVC = UINavigationController(rootViewController: collectionVC)
        let profileNavVC = UINavigationController(rootViewController: profileVC)
        
        mainNavVC.tabBarItem = UITabBarItem(title: "Главное", image: UIImage(named: "tv"), tag: 0)
        mainNavVC.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)

        collectionVC.tabBarItem = UITabBarItem(title: "Коллекция", image: UIImage(named: "favorite"), tag: 1)
        collectionNavVC.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        
        profileVC.tabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "user"), tag: 2)
        profileNavVC.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)

        self.viewControllers = [mainNavVC, collectionNavVC, profileNavVC]
        
        self.tabBar.tintColor = UIColor(named: "AccentColor")
    }
}
