//
//  TopPostTableViewCell.swift
//  RLReddit
//
//  Created by Taras Galagodza on 9/4/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import UIKit

class TopPostTableViewCell: UITableViewCell {

    private static let dateFormatter = DateComponentsFormatter()

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var commentsCountLabel: UILabel!
    @IBOutlet weak var createdUtcLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!

    var post: Post? {
        didSet {
            thumbnailImageView?.image = UIImage.init(imageLiteralResourceName: "no-pictures-available_icon")
            if let post = post {
                titleLabel.text = post.title;
                authorLabel.text = post.author;
                thumbnailImageView.downloadedFrom(link: post.thumbnailPath);
                commentsCountLabel.text = "Comments: \(post.commentsCount)"
                let date = Date(timeIntervalSince1970: TimeInterval(post.createdUtc))
                if let string = TopPostTableViewCell.dateFormatter.string(from: date, to: Date()) {
                    createdUtcLabel.text = string + " ago"
                }
                else {
                    createdUtcLabel.text = ""
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        TopPostTableViewCell.dateFormatter.maximumUnitCount = 1
        TopPostTableViewCell.dateFormatter.unitsStyle = .full
    }
}
