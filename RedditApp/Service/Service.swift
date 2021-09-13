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
    
    func searchPost(completion: @escaping (Result<[Post], Error>) -> Void) {
        guard let url = URL(string: "https://www.reddit.com/r/all/top.json?limit=20") else {
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
                    completion(.success(response.data.children ))
                }
                catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
