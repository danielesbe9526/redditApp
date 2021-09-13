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
    @IBOutlet weak private var numberOfComments: UILabel!
    @IBOutlet weak private var entryDate: UILabel!
    @IBOutlet weak private var thumbnail: UIImage!
    @IBOutlet weak private var unreadStatus: UIView!
    @IBOutlet weak private var comentsTopConstraint: NSLayoutConstraint!
    @IBOutlet weak private var entryDateTopConstraint: NSLayoutConstraint!
}
