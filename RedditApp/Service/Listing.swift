//
//  Listing.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import Foundation

// MARK: - List
struct List: Codable {
    let data: ListData
}

// MARK: - ListData
struct ListData: Codable {
    let after: String
    let children: [Post]
}

// MARK: - Post
struct Post: Codable {
    let kind: String
    var data: PostData
}

// MARK: - ChildData
struct PostData: Codable {
    let title: String
    var clicked: Bool
    let thumbnail: String
    let author: String
    let numComments: Int
    let created: Int
    let isVideo: Bool
    let url: String

    enum CodingKeys: String, CodingKey {
        case title
        case thumbnail
        case author, clicked, created, url
        case numComments = "num_comments"
        case isVideo = "is_video"
    }
}
