//
//  HomeViewModelProtocol.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 27.02.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var delegate: HomeViewControllerDelegate? { get set }
    var jokes: [HomeCellType] { get }
    func getRemoteJoke()
    func getFavoriteJoke()
    func getJoke(id: String) -> JokeModelProtocol?
    func saveJoke(item: JokeModelProtocol)
    func deleteJoke(item: JokeModelProtocol)
}
