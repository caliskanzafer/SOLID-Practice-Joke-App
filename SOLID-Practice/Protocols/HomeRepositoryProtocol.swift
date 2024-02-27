//
//  HomeRepositoryProtocol.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 27.02.2024.
//

import Foundation

protocol HomeRepositoryProtocol {
    func getFavoriteJoke() -> [JokeModelProtocol]
    func getJoke(id: String) -> JokeModelProtocol?
    func saveFavoriteJoke(item: JokeModelProtocol)
    func deleteJoke(item: JokeModelProtocol)
    func deleteAllJokes()
    func getJokeEntity()
}
