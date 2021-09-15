//
//  PostListViewModel.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import Foundation
import UIKit

protocol PostViewModelDelegate {
    func listOfTopPosts(_ list: ListData?)
}

class PostListViewModel {
    
    var delegate: PostViewModelDelegate?
    var listData: ListData?
    let service = RedditService()
    
    func searchPost() {
        service.searchPost(afterId: listData?.after ?? "") { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let listData):
                    self?.listData = listData
                    self?.delegate?.listOfTopPosts(listData)
                case .failure:
                    self?.delegate?.listOfTopPosts(nil)
                }
            }
        }
    }
}
