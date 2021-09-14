//
//  MainViewVM.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import Foundation

protocol MainViewDelegate {
    func listOfTopPosts(_ list: ListData?)
}

class MainViewVM {
    var delegate: MainViewDelegate?
    var listData: ListData?

    func searchPost() {
        let service = RedditService()
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
