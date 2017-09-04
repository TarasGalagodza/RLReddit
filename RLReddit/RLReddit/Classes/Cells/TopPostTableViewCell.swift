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
    var post: Post? {
        didSet {
            if let post = post {
                titleLabel.text = post.title;
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
