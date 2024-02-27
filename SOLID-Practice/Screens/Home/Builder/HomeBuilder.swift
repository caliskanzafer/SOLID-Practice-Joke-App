//
//  HomeBuilder.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 27.02.2024.
//

import UIKit

enum HomeBuilder {
    static func generate() -> UIViewController {
        let manager: RepositoryManagerProtocol = SqliteManager()
        let service: NetworkServiceProtocol = NetworkService()
        
        let homeService: HomeServiceProtocol = HomeService(service: service)
        let homeRepository: HomeRepositoryProtocol = HomeRepository(manager: manager)
        let homeViewModel: HomeViewModelProtocol = HomeViewModel(repository: homeRepository, service: homeService)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        return homeViewController
    }
}
