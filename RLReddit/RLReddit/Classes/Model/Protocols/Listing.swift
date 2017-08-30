//
//  Listing.swift
//  RLReddit
//
//  Created by Taras Galagodza on 8/30/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import Foundation

protocol Listing {
    associatedtype EntitiesType
    init(entities: [EntitiesType], before: String, after: String)
    
    static func +(left: Self, right: Self) -> Self
}
