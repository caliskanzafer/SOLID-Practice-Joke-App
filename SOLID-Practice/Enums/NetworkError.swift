//
//  NetworkError.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidResponse
    case unexpectedError(_ message: String)
}
