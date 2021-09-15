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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(addTapped))
    }
    
    @objc func addTapped(_ sender: AnyObject) {
        let size = self.posts.count - 1
        self.viewModel.listData = nil
        var indexPaths: [IndexPath] = []
        
        for index in stride(from: size, through: 0, by: -1) {
            let indexPath = IndexPath(row: index, section: 0)
            indexPaths.append(indexPath)
            self.posts.remove(at: indexPath.row)
        }
        
        UIView.animate(withDuration: 0.9) {
            self.tableView.deleteRows(at: indexPaths, with: .middle)
            self.tableView.reloadData()
        }
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

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            posts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
         }
    }
}

extension PostListTableViewController: PostViewModelDelegate {
    func listOfTopPosts(_ list: ListData?) {
        isPageRefreshing = false
        refreshControl?.endRefreshing()
        
        guard let list = list else { return }
        viewModel.listData = list
        posts += list.children
        tableView.reloadData()
    }
}
