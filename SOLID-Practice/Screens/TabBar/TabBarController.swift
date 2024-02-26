//
//  TabBarController.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//


import UIKit

class CustomTabBarController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        let viewModel = HomeViewModel()
        let tabBarController = UITabBarController()
        let feedItem = HomeViewController(viewModel: viewModel)
        feedItem.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        
        tabBarController.tabBar.unselectedItemTintColor = UIColor.black
        tabBarController.tabBar.barTintColor = .green
        tabBarController.tabBar.tintColor = UIColor.purple
        tabBarController.tabBar.backgroundColor = UIColor.lightGray
        tabBarController.tabBar.layer.cornerRadius = 2
        tabBarController.tabBar.layer.opacity = 10
        
        let uploadItem = SettingsViewController(viewModel: viewModel)
        uploadItem.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "square.and.arrow.up.circle"), tag: 1)
        
        tabBarController.viewControllers = [feedItem,uploadItem]
        self.view.addSubview(tabBarController.view)
        self.addChild(tabBarController)
        
        tabBarController.didMove(toParent: self)
     
    }
    


}
