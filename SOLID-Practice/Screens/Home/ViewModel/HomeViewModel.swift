//
//  HomeViewModel.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

enum HomeCellType: Equatable {
    case remote(_ joke: JokeModel? = nil)
    case favorite(_ jokes: [JokeModel]? = nil)
    
    static func == (lhs: HomeCellType, rhs: HomeCellType) -> Bool {
        switch (lhs, rhs) {
        case (.remote, .remote),
            (.favorite, .favorite):
            return true
        default:
            return false
        }
    }
    
    var orderIndex: Int {
        switch self {
        case .remote:
            1
        case .favorite:
            2
        }
    }
}

import UIKit

final class HomeViewModel {
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
    
    
    func getFavoriteJoke() {
        let jokeList = coreDataService.getJokes()
        
        jokes.removeAll(where: { cell in
            cell == .favorite()
        })
        
        jokes.append(.favorite(jokeList))
        
        delegate?.reloadTableView()
    }
    
    func saveFavoriteJoke(item: JokeModel) {
        coreDataService.saveFavoriteJoke(item: item)
    }

}
