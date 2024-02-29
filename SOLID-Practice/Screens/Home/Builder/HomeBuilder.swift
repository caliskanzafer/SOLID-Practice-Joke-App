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
        let homeDataProvider: HomeDataProviderProtocol = HomeDataProvider(repository: homeRepository, service: homeService)
        let homeViewModel: HomeViewModelProtocol = HomeViewModel(dataProvider: homeDataProvider)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        
        return homeViewController
    }
}
