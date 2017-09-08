//
//  Article.swift
//  RLReddit
//
//  Created by Taras Galagodza on 8/29/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import Foundation

class Post: NSObject, NSCoding {

    let title: String
    let author: String
    let createdUtc: Int
    let thumbnailPath: String
    let fullSizeImagePath: String
    let commentsCount: Int
    
    var hasFullSizeImageLink: Bool {
        // support only images
        return !fullSizeImagePath.isEmpty && (fullSizeImagePath.hasSuffix(".png") || fullSizeImagePath.hasSuffix(".jpg"))
    }

    
    init(title: String, author: String, createdUtc: Int, thumbnailPath: String, fullSizeImagePath: String, commentsCount: Int) {
        self.title = title
        self.author = author
        self.createdUtc = createdUtc
        self.thumbnailPath = thumbnailPath
        self.fullSizeImagePath = fullSizeImagePath
        self.commentsCount = commentsCount
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let title = decoder.decodeObject(forKey: "title") as? String,
            let author = decoder.decodeObject(forKey: "author") as? String,
            let createdUtc = decoder.decodeObject(forKey: "createdUtc") as? Int,
            let thumbnailPath = decoder.decodeObject(forKey: "thumbnailPath") as? String,
            let fullSizeImagePath = decoder.decodeObject(forKey: "fullSizeImagePath") as? String,
            let commentsCount = decoder.decodeObject(forKey: "commentsCount") as? Int

            else { return nil }
        
        self.init(title: title, author: author, createdUtc: createdUtc, thumbnailPath: thumbnailPath, fullSizeImagePath:fullSizeImagePath, commentsCount: commentsCount)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(author, forKey: "author")
        aCoder.encode(createdUtc, forKey: "createdUtc")
        aCoder.encode(thumbnailPath, forKey: "thumbnailPath")
        aCoder.encode(fullSizeImagePath, forKey: "fullSizeImagePath")
        aCoder.encode(commentsCount, forKey: "commentsCount")
    }
}

extension Post: JSONDecodable {
    static func decode(json: Any) -> Post? {
        guard let dataDictionary = json as? [String: Any],
            let articleData = dataDictionary["data"] as? [String: Any]
            else { return nil }

            let title = articleData["title"] as? String ?? ""
            let author = articleData["author"] as? String ?? ""
            let createdUtc = articleData["created_utc"] as? Int ?? 0
            let thumbnailPath = articleData["thumbnail"] as? String ?? ""
            let fullSizeImagePath = articleData["url"] as? String ?? ""
            let commentsCount = articleData["num_comments"] as? Int ?? 0

            return Post(title: title, author: author, createdUtc: createdUtc, thumbnailPath: thumbnailPath, fullSizeImagePath:fullSizeImagePath, commentsCount: commentsCount)
    }
}
