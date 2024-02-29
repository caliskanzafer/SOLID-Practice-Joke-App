//
//  HomeDataProviderProtocol.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 29.02.2024.
//

import Foundation

protocol HomeDataProviderProtocol {
    func getRemoteJoke(completion: @escaping (JokeModelProtocol?) -> Void)
    func getFavoriteJokes() -> [JokeModelProtocol]
    func getJoke(id: String) -> JokeModelProtocol?
    func saveJoke(item: JokeModelProtocol)
    func deleteJoke(item: JokeModelProtocol)
}
