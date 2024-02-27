//
//  HomeViewModel.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    let repository: HomeRepositoryProtocol
    let service: HomeServiceProtocol
    
    init(repository: HomeRepositoryProtocol, service: HomeServiceProtocol) {
        self.repository = repository
        self.service = service
    }
    
    weak var delegate: HomeViewControllerDelegate?
    
    var jokes: [HomeCellType] = [] {
        didSet {
            jokes.sort(by: { s1, s2 in
                s1.orderIndex < s2.orderIndex
            })
        }
    }
    
    func getRemoteJoke() {
        service.getRemoteJoke { [weak self] response in
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
        let jokeList = repository.getFavoriteJoke()
        
        jokes.removeAll(where: { cell in
            cell == .favorite()
        })
        
        jokes.append(.favorite(jokeList))
        
        delegate?.reloadTableView()
    }
    
    func getJoke(id: String) -> JokeModelProtocol? {
        return repository.getJoke(id: id)
    }
    
    func saveJoke(item: JokeModelProtocol) {
        repository.saveFavoriteJoke(item: item)
    }
    
    func deleteJoke(item: JokeModelProtocol) {
        repository.deleteJoke(item: item)
    }

}
