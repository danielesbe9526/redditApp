//
//  ViewController.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    private var viewModel = MainViewVM()
    var posts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setUpCollectionView()
        viewModel.searchPost()
    }
    
    private func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let nib = UINib(nibName: "PostCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PostCollectionViewCell")
    }
}

extension ViewController: MainViewDelegate {
    func topPost(_ post: [Post]?) {
        guard let posts = post else { return }
        self.posts = posts
        self.collectionView.reloadData()
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
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 2) - 25, height: 250)
       }
}
