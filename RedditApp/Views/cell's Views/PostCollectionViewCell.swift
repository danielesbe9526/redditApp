//
//  PostCollectionViewCell.swift
//  RedditApp
//
//  Created by Daniel Esteban Beltran Beltran on 13/09/21.
//

import UIKit

class PostCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak private var title: UILabel!
    @IBOutlet weak private var author: UILabel!
    @IBOutlet weak private var entryDate: UILabel!
    @IBOutlet weak private var numberOfComments: UILabel!
    @IBOutlet weak private var thumbnail: UIImageView!
    @IBOutlet weak private var readStatus: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureWith(post: ChildData) {
        title.numberOfLines = 0
        title.text = post.title
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
}
