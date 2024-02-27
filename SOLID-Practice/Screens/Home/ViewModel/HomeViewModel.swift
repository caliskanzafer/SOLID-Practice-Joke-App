//
//  HomeViewModel.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import Foundation

final class HomeViewModel {
    var networkService = NetworkService()
//    var coreDataService = CoreDataService()
    var sqliteService = SqliteService()
    
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
//        let jokeList = coreDataService.getJokes()
        let jokeList = sqliteService.getJokes()
        
        jokes.removeAll(where: { cell in
            cell == .favorite()
        })
        
        jokes.append(.favorite(jokeList))
        
        delegate?.reloadTableView()
    }
    
    func getJoke(id: String) -> JokeModel? {
//        return coreDataService.getJoke(id: id)
        return sqliteService.getJoke(id: id)
    }
    
    func saveFavoriteJoke(item: JokeModel) {
//        coreDataService.saveJoke(item: item)
        sqliteService.saveJoke(item: item)
    }
    
    func deleteJoke(item: JokeModel) {
//        coreDataService.deleteJoke(item: item)
        sqliteService.deleteJoke(item: item)
    }
    
    func deleteAllJokes() {
//        coreDataService.deleteAllData()
        sqliteService.deleteAllData()
    }

}
