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
    let data: PostData
}

// MARK: - ChildData
struct PostData: Codable {
    let title: String
    let clicked: Bool
    let thumbnail: String
    let author: String
    let numComments: Int
    let created: Int

    enum CodingKeys: String, CodingKey {
        case title
        case thumbnail
        case author, clicked, created
        case numComments = "num_comments"
    }
}
