//
//  SceneDelegate.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard
          let splitViewController = window?.rootViewController as? UISplitViewController,
          let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
          let masterViewController = leftNavController.viewControllers.first as? PostListTableViewController,
          let detailViewController = (splitViewController.viewControllers.last as? UINavigationController)?.topViewController as? PostDetailViewController
          else { fatalError() }
        
        let firstPost = masterViewController.posts.first
        detailViewController.post = firstPost?.data
        masterViewController.delegate = detailViewController
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
    }
}

