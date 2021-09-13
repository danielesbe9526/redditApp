//
//  MainViewVM.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import Foundation

protocol MainViewDelegate {
    func topPost(_ post: [Post]?)
}

class MainViewVM {
    var delegate: MainViewDelegate?
    
    func searchPost() {
        let service = RedditService()
        service.searchPost { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self?.delegate?.topPost(posts)
                case .failure:
                    self?.delegate?.topPost(nil)
                }
            }
        }
    }
}
