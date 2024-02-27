//
//  HomeCellDelegate.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 28.02.2024.
//

import Foundation

protocol HomeCellDelegate: AnyObject {
    func updateTableView()
    func updateJoke()
    func getJoke(id: String) -> JokeModel?
    func saveJoke(item: JokeModel)
    func deleteJoke(item: JokeModel)
}
