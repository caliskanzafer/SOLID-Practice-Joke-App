//
//  RepositoryProtocol.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 27.02.2024.
//

import Foundation

protocol RepositoryService {
    func getJokes() -> [JokeModel]
    func getJoke(id: String) -> JokeModel?
    func getJokeEntity(id: String) -> [JokeEntity]?
    func saveJoke(item: JokeModel)
    func deleteJoke(item: JokeModel)
    func deleteAllData()
}
