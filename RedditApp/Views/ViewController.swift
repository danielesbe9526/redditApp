//
//  ViewController.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var collectionView: UICollectionView!

    let refreshControl = UIRefreshControl()
    private var viewModel = MainViewVM()
    var posts: [Post] = []
    var page: Int = 0
    var isPageRefreshing:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setUpCollectionView()
        viewModel.searchPost()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        collectionView.addSubview(refreshControl) // not required when using UITableViewController
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PostCollectionViewCell")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.collectionView.contentOffset.y >= (self.collectionView.contentSize.height - self.collectionView.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                viewModel.searchPost()
            }
        }
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.searchPost()
    }
}

extension ViewController: MainViewDelegate {
    func listOfTopPosts(_ list: ListData?) {
        guard let list = list else { return }
        self.viewModel.listData = list
        self.posts += list.children
        self.collectionView.reloadData()
        isPageRefreshing = false
        refreshControl.endRefreshing()
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCollectionViewCell", for: indexPath) as! PostCollectionViewCell
        cell.configureWith(post: posts[indexPath.row].data)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageViewController = ImageViewController()

        posts[indexPath.row].data.clicked = true
        collectionView.reloadData()
        
        self.navigationController?.present(imageViewController, animated: true, completion: {
            imageViewController.loadImageWith(URL(string: self.posts[indexPath.row].data.thumbnail))
        })
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("width: \(view.frame.width) height: \(view.frame.height)")
        return CGSize(width: (view.frame.width / 2) - 25, height: 250)
    }
}
