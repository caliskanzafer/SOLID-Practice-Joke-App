//
//  HomeCellDelegate.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 27.02.2024.
//

import Foundation

protocol HomeCellDelegate: AnyObject {
    func updateTableView()
    func getJoke(id: String) -> JokeModelProtocol?
    func saveJoke(item: JokeModelProtocol)
    func deleteJoke(item: JokeModelProtocol)
}
