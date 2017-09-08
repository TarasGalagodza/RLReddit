//
//  RLRedditTests.swift
//  RLRedditTests
//
//  Created by Taras Galagodza on 8/14/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import XCTest
@testable import RLReddit

class RLRedditTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        do {
            if let file = Bundle.main.url(forResource: "sample", withExtension: "json")
            {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])

                let listing = PostsListing.decode(json: json)
                XCTAssertNotNil(listing)
                XCTAssertEqual(listing?.before, "")
                XCTAssertEqual(listing?.after, "t3_5ds8h3")
                XCTAssertEqual(listing?.entities.count, 25)
                
                if let firstPost = listing?.entities.first {
                    XCTAssertEqual(firstPost.title, "Guardians of the Front Page")
                    XCTAssertEqual(firstPost.author, "iH8myPP" )
                    XCTAssertEqual(firstPost.commentsCount, 5041)
                    XCTAssertEqual(firstPost.thumbnailPath, "https://b.thumbs.redditmedia.com/yeLMMXr9vghtaz26xZ1A_PCg-vk4_KjtnHNlQ-NzkxA.jpg")
                    XCTAssertEqual(firstPost.fullSizeImagePath, "http://i.imgur.com/OOFRJvr.gifv")
                    XCTAssertEqual(firstPost.createdUtc, 1480959674)
                    
                } else {
                    XCTFail()
                }
            } else {
                XCTFail()
            }
        } catch {
            print(error.localizedDescription)
            XCTFail()
        }
    }
}
