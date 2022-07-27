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
    
    static func fetchGoodInfo(from url: String, with completion: @escaping(Result<[Good], NetworkError>) -> Void) {
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
                let goodsInfo = try JSONDecoder().decode([Good].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(goodsInfo))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }
        .resume()
    }
}
