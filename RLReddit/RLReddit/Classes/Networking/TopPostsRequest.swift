//
//  TopArticlesRequest.swift
//  RLReddit
//
//  Created by Taras Galagodza on 8/29/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import Foundation

class TopPostsRequest: Request {
    private static let maxPostsPerPage = 50

    init(after: String = "", count: Int = maxPostsPerPage, limit: Int = maxPostsPerPage) {
        var url: URL? = nil
        if var urlComponents = URLComponents(string:(Request.baseURL + "/top.json")) {
            var items = [URLQueryItem]()
            items.append(URLQueryItem(name: "count", value: String(count)))
            items.append(URLQueryItem(name: "limit", value: String(limit)))
            items.append(URLQueryItem(name: "after", value: after))
            urlComponents.queryItems = items
            url = urlComponents.url
        } else {
            assertionFailure("failed to create top post URL")
        }

        super.init(url: url!)
    }
    
    override func parse(json: Any) -> Any? {
        return PostsListing.decode(json: json);
    }
}
