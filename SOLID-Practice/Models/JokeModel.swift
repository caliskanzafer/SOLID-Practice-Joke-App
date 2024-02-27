//
//  JokeModel.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import Foundation

protocol JokeModelProtocol {
    var id: String? { get }
    var value: String? { get }
}

struct JokeModel: Codable, JokeModelProtocol {
    let id: String?
    let value: String?
}
