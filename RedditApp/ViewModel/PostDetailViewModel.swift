//
//  PostDetailViewModel.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 14/09/21.
//

import Foundation
import UIKit

class PostDetailViewModel {
    let service = RedditService()
    
    func searchImage(with value: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: value) else { return }
        service.downloadImage(url: url) { image in
            completion(image)
        }
    }
    
    func getDate(from post: PostData) -> String {
        let dateTime = post.created
        let postDate = Date(timeIntervalSince1970: Double(dateTime))
        return postDate.timeAgoDisplay()
    }
}
