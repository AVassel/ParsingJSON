//
//  NetworkManager.swift
//  ParsingJSON
//
//  Created by Anton Vassel on 10.06.2022.
//

import Foundation

class NetworkManager {
    
    static func fetchGoodInfo(from url: String?, with completion: @escaping(_ good: [Good]) -> () ) {
        guard let url = URL(string: url ?? "") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let goodsInfo = try JSONDecoder().decode([Good].self, from: data)
                completion(goodsInfo)
            } catch let error {
                print(error.localizedDescription)
            }
        }
        .resume()
    }
}
