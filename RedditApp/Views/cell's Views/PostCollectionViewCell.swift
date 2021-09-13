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

    func configureWith(post: PostData) {
        title.numberOfLines = 0
        title.text = post.title
        author.text = post.author
        numberOfComments.text = "comments: \(post.numComments)"
        readStatus.backgroundColor = post.clicked ? #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1) : #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        entryDate.text = getDate(from: post)
        thumbnail.downloaded(from: post.thumbnail, contentMode: .scaleAspectFill)
        self.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    private func getDate(from post: PostData) -> String {
        let dateTime = post.created
        let postDate = Date(timeIntervalSince1970: Double(dateTime))
        return postDate.timeAgoDisplay()
    }
}
