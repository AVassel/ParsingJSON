//
//  NetworkManager.swift
//  ParsingJSON
//
//  Created by Anton Vassel on 10.06.2022.
//

import Foundation

class NetworkManager {
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
    }
    
    static func fetch<T: Decodable>(dataType: T.Type, from url: String, with completion: @escaping(Result<T, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
