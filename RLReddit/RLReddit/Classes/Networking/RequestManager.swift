//
//  RLRequestManager.swift
//  RLReddit
//
//  Created by Taras Galagodza on 8/16/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import UIKit
import Foundation

class RequestManager {
    
    static let sharedInstance = RequestManager()
    private var session = URLSession(configuration: URLSessionConfiguration.default)
    private lazy var requests: Array<Request> = [Request]()

    func sendRequest(request: Request, completionHandler: @escaping(Any?, NSError) -> Void) {
        request.cancelRequest()
        self.requests.append(request)
        request.sendRequestWithSession(session: session)
    }
}
