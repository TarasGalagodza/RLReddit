//
//  PaginatedList.swift
//  RLReddit
//
//  Created by Taras Galagodza on 8/30/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import Foundation

class PostsListing: NSObject, NSCoding {

    var before: String
    var after: String
    var entities: [Post]
    
    required init(entities: [Post], before: String, after: String) {
        self.entities = entities
        self.before = before
        self.after = after
    }

    static func +(left: PostsListing, right: PostsListing) -> PostsListing {
        let entities = left.entities + right.entities
        return PostsListing(entities: entities, before: left.before, after:right.after)
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let before = decoder.decodeObject(forKey: "before") as? String,
            let after = decoder.decodeObject(forKey: "after") as? String,
            let entities = decoder.decodeObject(forKey: "entities") as? [Post]
        
            else { return nil }
        
        self.init(entities: entities, before: before, after: after)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(before, forKey: "before")
        aCoder.encode(after, forKey: "after")
        aCoder.encode(entities, forKey: "entities")
    }
}

extension PostsListing: JSONDecodable {
    static func decode(json: Any) -> PostsListing? {
        guard let dataDictionary = json as? [String: Any],
            let listData = dataDictionary["data"] as? [String: Any]
            else { return nil }
        
        var entities = [Post]()
        if let children = listData["children"] as? [Any] {
            for entity in children {
                if let post = Post.decode(json: entity) {
                    entities.append(post)
                }
            }
        }
        let after = listData["after"] as? String ?? ""
        let before = listData["before"] as? String ?? ""
        
        return PostsListing(entities: entities, before: before, after:after)
    }
}
