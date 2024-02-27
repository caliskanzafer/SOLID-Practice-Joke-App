//
//  HomeServiceProtocol.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 27.02.2024.
//

import Foundation

protocol HomeServiceProtocol {
    func getRemoteJoke(completion: @escaping (Result<JokeModelProtocol, NetworkError>) -> Void)
}
