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
    var posts: [Child] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        viewModel.searchPost()
    }
}

extension ViewController: MainViewDelegate {
    func topPost(_ post: [Child]?) {
        guard let posts = post else { return }
        self.posts = posts
    }
}


extension ViewController: UICollectionViewDelegate {

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let identifier = "postCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PostCollectionViewCell
        
//        cell.itemLabel.text = posts[indexPath.row]
//        cell.itemImage.image = UIImage.init(imageLiteralResourceName: posts[indexPath.row])
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return posts.count
    }
}
