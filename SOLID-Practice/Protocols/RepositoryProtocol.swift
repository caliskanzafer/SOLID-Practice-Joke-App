//
//  RepositoryProtocol.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 27.02.2024.
//

import Foundation

protocol RepositoryManagerProtocol {
    func getJokes() throws -> [JokeModelProtocol]
    func getJoke(id: String) -> JokeModelProtocol?
    func saveJoke(item: JokeModelProtocol)
    func deleteJoke(item: JokeModelProtocol)
    func deleteAllData()
}
