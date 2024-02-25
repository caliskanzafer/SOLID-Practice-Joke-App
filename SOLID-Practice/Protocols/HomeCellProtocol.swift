//
//  HomeCellProtocol.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import Foundation

protocol HomeCellProtocol {
    
    var joke: JokeModel? { get }
    var isExist: Bool { get set }
    var updateTableView: (() -> Void)? { get set }
    var updateJoke: (() -> Void)? { get set }
}
