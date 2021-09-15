//
//  PostDetailViewController.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import UIKit

class PostDetailViewController: UIViewController {
    
    @IBOutlet weak  var postTitle: UILabel!
    @IBOutlet weak  var author: UILabel!
    @IBOutlet weak  var entryDate: UILabel!
    @IBOutlet weak  var numberOfComments: UILabel!
    @IBOutlet weak  var thumbnail: UIImageView!
    @IBOutlet weak  var readStatus: UIView!
    @IBOutlet weak  var saveButton: UIButton!
    @IBOutlet weak  var cardView: UIView!
    
    private var viewModel = PostDetailViewModel()
    var isfirstLauch = true
    
    var post: PostData? {
        didSet {
            configureUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTitle.numberOfLines = 0
        saveButton.layer.cornerRadius = 5
        readStatus.layer.cornerRadius = 10

        setUpCardView()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView(_:)))
        cardView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func configureUI() {
        guard let post = post else { return }
        
        viewModel.searchImage(with: post.thumbnail) { image in
            DispatchQueue.main.async { [weak self] in
                self?.thumbnail.contentMode = .scaleAspectFit
                self?.thumbnail.image = image
            }
        }
        
        postTitle.text = post.title
        author.text = "Author: \(post.author)"
        numberOfComments.text = "comments: \(post.numComments)"
        readStatus.backgroundColor = post.clicked ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        entryDate.text = viewModel.getDate(from: post)
    }
    
    private func setUpCardView() {
        cardView.layer.shadowColor = UIColor.black.cgColor
        cardView.layer.shadowOpacity = 1
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 10
        cardView.layer.cornerRadius = 5
    }
    
    @objc func didTapView(_ sender: UITapGestureRecognizer) {
        if let post = post, !post.isVideo, let imageURL = URL(string: post.url) {
            let imageViewController = ImageViewController()
            
            navigationController?.present(imageViewController, animated: true, completion: {
                imageViewController.loadImageWith(imageURL)
            })
        }
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
        post = newPost.data
    }
}
