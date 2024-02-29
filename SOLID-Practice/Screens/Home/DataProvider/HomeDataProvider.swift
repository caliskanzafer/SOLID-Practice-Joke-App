//
//  HomeDataProvider.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 29.02.2024.
//

import Foundation

final class HomeDataProvider: HomeDataProviderProtocol {
    
    let repository: HomeRepositoryProtocol
    let service: HomeServiceProtocol
    
    init(repository: HomeRepositoryProtocol, service: HomeServiceProtocol) {
        self.repository = repository
        self.service = service
    }
    
    func getRemoteJoke(completion: @escaping (JokeModelProtocol?) -> Void) {
        service.getRemoteJoke { result in
            switch result {
            case .success(let joke):
                completion(joke)
            case .failure(let failure):
                completion(nil)
            }
        }
    }
    
    func getFavoriteJokes() -> [JokeModelProtocol] {
        return repository.getFavoriteJoke()
    }
    
    func getJoke(id: String) -> JokeModelProtocol? {
        return repository.getJoke(id: id)
    }
    
    func saveJoke(item: JokeModelProtocol) {
        return repository.saveFavoriteJoke(item: item)
    }
    
    func deleteJoke(item: JokeModelProtocol) {
        repository.deleteJoke(item: item)
    }
}
