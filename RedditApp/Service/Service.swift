//
//  Service.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import Foundation
import UIKit

class RedditService {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = .init()) {
        self.session = session
        self.decoder = decoder
    }
    
    func searchPost(afterId: String, completion: @escaping (Result<ListData, Error>) -> Void) {
        guard let url = URL(string: "https://www.reddit.com/r/all/top.json?limit=10&after=\(afterId)") else {
            preconditionFailure("Failed to construct search URL ")
        }
                
        session.dataTask(with: url) {data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            else {
                do {
                    let data = data ?? Data()
                    let response = try JSONDecoder().decode(List.self, from: data)
                    completion(.success(response.data))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    
    func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void) {
        session.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { completion(nil)
                return
            }
            DispatchQueue.main.async() {
                completion(image)
            }
        }.resume()
    }
}
