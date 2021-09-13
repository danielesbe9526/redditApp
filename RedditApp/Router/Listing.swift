//
//  Listing.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import Foundation

struct Listing {
    var posts = [Post]()
}

// MARK: - Decodable

extension Listing: Decodable {
    enum CodingKeys: String, CodingKey {
        case posts = "children"
        case data
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        
        posts = try data.decode([Post].self, forKey: .posts)
    }
}

// MARK: - List
struct List: Codable {
    let kind: String
    let data: ListData
}

// MARK: - ListData
struct ListData: Codable {
    let after: String
    let dist: Int
    let modhash: String
    let geoFilter: String?
    let children: [Child]
    let before: String?

    enum CodingKeys: String, CodingKey {
        case after, dist, modhash
        case geoFilter = "geo_filter"
        case children, before
    }
}

// MARK: - Child
struct Child: Codable {
    let kind: String
    let data: ChildData
}

// MARK: - ChildData
struct ChildData: Codable {
    let title: String

    enum CodingKeys: String, CodingKey {
        case title
    }
}
