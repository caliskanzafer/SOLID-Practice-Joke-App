//
//  HomeService.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 27.02.2024.
//

import Foundation

final class HomeService: HomeServiceProtocol {
    
    let service: NetworkServiceProtocol
    
    init(service: NetworkServiceProtocol) {
        self.service = service
    }
    
    func getRemoteJoke(completion: @escaping (Result<JokeModelProtocol, NetworkError>) -> Void) {
        service.getJoke(completion: completion)
    }
}
