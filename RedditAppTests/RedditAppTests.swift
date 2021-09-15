//
//  RedditAppTests.swift
//  RedditAppTests
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import XCTest
@testable import RedditApp

class RedditAppTests: XCTestCase {

    var viewModel = PostDetailViewModel()
    let postData = PostData(title: "Test", clicked: false, thumbnail: "", author: "Author", numComments: 99, created: 1631525364, isVideo: false, url: "some URL")
    let postDetailVC = PostDetailViewController()
    
    override func setUpWithError() throws {
        viewModel = PostDetailViewModel()
    }
}
