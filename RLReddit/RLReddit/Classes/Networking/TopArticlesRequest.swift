//
//  TopArticlesRequest.swift
//  RLReddit
//
//  Created by Taras Galagodza on 8/29/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import UIKit

class TopArticlesRequest: Request {
    private static let maxArticlesPerPage = 50

    init(after: Int = 0, count: Int = maxArticlesPerPage, limit: Int = maxArticlesPerPage) {
        var url: URL? = nil
        if var urlComponents = URLComponents(string:(Request.baseURL + "/top.json")) {
            var items = [URLQueryItem]()
            items.append(URLQueryItem(name: "count", value: String(count)))
            items.append(URLQueryItem(name: "limit", value: String(limit)))
            items.append(URLQueryItem(name: "after", value: String(after)))
            urlComponents.queryItems = items
            url = urlComponents.url
        } else {
            assertionFailure("failed to create top artcles URL")
        }

        super.init(url: url!)
    }
}
