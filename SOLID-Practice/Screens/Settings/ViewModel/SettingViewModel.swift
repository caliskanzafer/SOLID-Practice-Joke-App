//
//  SettingViewModel.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import Foundation

final class SettingsViewModel {
    var networkService = NetworkService()
    var coreDataService = CoreDataService()
    
    weak var delegate: HomeViewControllerDelegate?
    
    var jokes: [HomeCellType] = [] {
        didSet {
            jokes.sort(by: { s1, s2 in
                s1.orderIndex < s2.orderIndex
            })
        }
    }
    
    func getRemoteJoke() {
        networkService.getJoke { [weak self] response in
            switch response {
            case .success(let joke):
                self?.jokes.removeAll(where: { cell in
                    cell == .remote()
                })
                
                self?.jokes.append(.remote(joke))
                
                
                self?.delegate?.reloadTableView()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

