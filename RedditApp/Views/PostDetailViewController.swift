//
//  PostDetailViewController.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak private var postTitle: UILabel!
    @IBOutlet weak private var author: UILabel!
    @IBOutlet weak private var entryDate: UILabel!
    @IBOutlet weak private var numberOfComments: UILabel!
    @IBOutlet weak private var thumbnail: UIImageView!
    @IBOutlet weak private var readStatus: UIView!
    @IBOutlet weak private var saveButton: UIButton!
    @IBOutlet weak private var cardView: UIView!
    
    private var viewModel = PostDetailViewModel()

    var post: PostData? {
        didSet {
            configureUI()
        }
    }
    
    private func configureUI() {
        guard let post = post else { return }
        
        viewModel.searchImage(with: post.thumbnail) { image in
            DispatchQueue.main.async { [weak self] in
                self?.thumbnail.contentMode = .scaleAspectFit
                self?.thumbnail.image = image
            }
        }
        
        postTitle.numberOfLines = 0
        postTitle.text = post.title
        
        author.text = "Author: \(post.author)"
        
        numberOfComments.text = "comments: \(post.numComments)"
        
        readStatus.backgroundColor = post.clicked ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        
        entryDate.text = viewModel.getDate(from: post)
        
        saveButton.layer.cornerRadius = 5
        readStatus.layer.cornerRadius = 10
        setUpCardView()
    }
    
    private func setUpCardView() {
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 10
        cardView.layer.cornerRadius = 5
    }
    
    @IBAction func save(_ sender: Any) {
        guard let image = thumbnail.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alertController = UIAlertController(title: "Save error", message: error.localizedDescription, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        } else {
            let alertController = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
    }
}

extension PostDetailViewController: PostSelectionDelegate {
    func postSelected(_ newPost: Post) {
        print("selected new post")
        post = newPost.data
    }
}
