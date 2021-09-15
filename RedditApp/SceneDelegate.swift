//
//  SceneDelegate.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var service = RedditService()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard
          let splitViewController = window?.rootViewController as? UISplitViewController,
          let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
          let masterViewController = leftNavController.viewControllers.first as? PostListTableViewController,
          let detailViewController = (splitViewController.viewControllers.last as? UINavigationController)?.topViewController as? PostDetailViewController
          else { fatalError() }

        searchPost(masterViewController, detailViewController)

        masterViewController.delegate = detailViewController
        detailViewController.navigationItem.leftItemsSupplementBackButton = true
        detailViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem
        
    }
    
    private func searchPost(_ masterViewController: PostListTableViewController , _ detailViewController: PostDetailViewController) {
        service.searchPost(afterId: "") { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let listData):
                    detailViewController.post = listData.children.first?.data
                    masterViewController.posts = listData.children
                case .failure:
                    return
                }
            }
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
        guard
          let splitViewController = window?.rootViewController as? UISplitViewController,
          let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
          let masterViewController = leftNavController.viewControllers.first as? PostListTableViewController,
          let detailViewController = (splitViewController.viewControllers.last as? UINavigationController)?.topViewController as? PostDetailViewController
          else { return }
        
        searchPost(masterViewController, detailViewController)
    }
}

