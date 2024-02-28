//
//  HomeViewModel.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import Foundation

final class HomeViewModel {
    var networkService = NetworkService()
//    var coreDataManager = CoreDataManager()
    var sqliteManager = SqliteManager()
    
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
//        let jokeList = coreDataManager.getJokes()
        do {
            let jokeList = try sqliteManager.getJokes()
            jokes.removeAll(where: { cell in
                cell == .favorite()
            })
            
            jokes.append(.favorite(jokeList))
            
            delegate?.reloadTableView()
            
        }catch SqliteError.fetchError {
            print("SqliteError")
        }catch CoreDataError.fetchError {
            print("CoreDataError")
        }catch {
            print("Unexpected Error")
        }
    }
    
    func getJoke(id: String) -> JokeModel? {
//        return coreDataManager.getJoke(id: id)
        return sqliteManager.getJoke(id: id)
    }
    
    func saveFavoriteJoke(item: JokeModel) {
//        coreDataManager.saveJoke(item: item)
        sqliteManager.saveJoke(item: item)
    }
    
    func deleteJoke(item: JokeModel) {
//        coreDataManager.deleteJoke(item: item)
        sqliteManager.deleteJoke(item: item)
    }
    
    func deleteAllJokes() {
//        coreDataManager.deleteAllData()
        sqliteManager.deleteAllData()
    }

}
