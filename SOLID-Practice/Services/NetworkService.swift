//
//  NetworkService.swift
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

final class NetworkService {
    private let urlSession = URLSession(configuration: .default)
    
    func getJoke(completion: @escaping (Result<JokeModel, NetworkError>) -> Void) {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else {
            completion(.failure(.invalidUrl))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "GET"
        
        urlSession.dataTask(with: request) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse,
                  200...200 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            do {
                let joke = try JSONDecoder().decode(JokeModel.self, from: data)
                
                completion(.success(joke))
            }catch {
                completion(.failure(.unexpectedError(error.localizedDescription)))
            }
        }
        .resume()
    }
}
