//
//  HomeRepository.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 27.02.2024.
//

import Foundation

typealias ManagerProtocol = RepositoryManagerProtocol

final class HomeRepository: HomeRepositoryProtocol {
    
    let manager: ManagerProtocol
    
    init(manager: ManagerProtocol) {
        self.manager = manager
    }
    
    func getFavoriteJoke() -> [JokeModelProtocol] {
        do {
            return try manager.getJokes()
        }catch ManagerError.fetchError {
            return []
        } catch {
            return []
        }
    }
    
    func getJoke(id: String) -> JokeModelProtocol? {
        return manager.getJoke(id: id)
    }
    
    func saveFavoriteJoke(item: JokeModelProtocol) {
        manager.saveJoke(item: item)
    }
    
    func deleteJoke(item: JokeModelProtocol) {
        manager.deleteJoke(item: item)
    }
    
    func deleteAllJokes() {
        manager.deleteAllData()
    }
    
    func getJokeEntity() {
//        let _ = manager.getJokeEntity(id: "")
    }
}
