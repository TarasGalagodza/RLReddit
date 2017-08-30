//
//  Parsable.swift
//  RLReddit
//
//  Created by Taras Galagodza on 8/29/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import Foundation

protocol JSONDecodable {
    associatedtype DecodableType
    static func decode(json: Any) -> DecodableType?
    static func decode(json: Any?) -> DecodableType?
}

extension JSONDecodable {
    static func decode(json: Any?) -> DecodableType? {
        guard let json = json else { return nil }
        return decode(json: json)
    }
}
