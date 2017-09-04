//
//  TopPostTableViewCell.swift
//  RLReddit
//
//  Created by Taras Galagodza on 9/4/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import UIKit

class TopPostTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var createdUtcLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!

    var post: Post? {
        didSet {
            if let post = post {
                titleLabel.text = post.title;
                authorLabel.text = post.author;
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
