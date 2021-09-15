//
//  PostListTableViewController.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 14/09/21.
//

import UIKit

protocol PostSelectionDelegate: AnyObject {
  func postSelected(_ newPost: Post)
}

class PostListTableViewController: UITableViewController {
    private var viewModel = PostListViewModel()
    var myRefreshControl = UIRefreshControl()

    var posts: [Post] = []
    private var isPageRefreshing: Bool = false
    private var isLandscape: Bool = false

    var delegate: PostSelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.delegate = self
        viewModel.searchPost()
        myRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        myRefreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.searchPost()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        isLandscape = UIDevice.current.orientation.isLandscape
        tableView.reloadData()
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(tableView.contentOffset.y >= (tableView.contentSize.height - tableView.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                viewModel.searchPost()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.sizeToFit()
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text =  posts[indexPath.row].data.title
      return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.postSelected(posts[indexPath.row])
        posts[indexPath.row].data.clicked = true

        if let detailViewController = delegate as? PostDetailViewController,
           let detailNavigationController = detailViewController.navigationController {
            splitViewController?.showDetailViewController(detailNavigationController, sender: nil)
        }
    }
}

extension PostListTableViewController: PostViewModelDelegate {
    func listOfTopPosts(_ list: ListData?) {
        guard let list = list else { return }
        tableView.reloadData()
        viewModel.listData = list
        posts += list.children
        isPageRefreshing = false
        refreshControl?.endRefreshing()
    }
}
