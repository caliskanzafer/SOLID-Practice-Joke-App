//
//  HomeCellType.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import Foundation

enum HomeCellType: Equatable {
    case remote(_ joke: JokeModelProtocol? = nil)
    case favorite(_ jokes: [JokeModelProtocol]? = nil)
    
    static func == (lhs: HomeCellType, rhs: HomeCellType) -> Bool {
        switch (lhs, rhs) {
        case (.remote, .remote),
            (.favorite, .favorite):
            return true
        default:
            return false
        }
    }
    
    var orderIndex: Int {
        switch self {
        case .remote:
            1
        case .favorite:
            2
        }
    }
}
