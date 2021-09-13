//
//  Service.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import Foundation

class RedditService {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func searchSubreddit(completion: @escaping (Result<[Child], Error>) -> Void) {
        guard let url = URL(string: "https://www.reddit.com/r/all/top.json?limit=20") else {
            preconditionFailure("Failed to construct search URL ")
        }
        
//    ion = adverstiment
        
        session.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                do {
                    let data = data ?? Data()
                    let response = try JSONDecoder().decode(List.self, from: data)
                    completion(.success(response.data.children ))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
