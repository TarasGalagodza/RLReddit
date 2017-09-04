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

    func sendRequest(request: Request, completionHandler: @escaping(Any?, NetworkError?) -> Void) {
        request.cancelRequest()
        requests.append(request)

        request.failureBlock = {[weak self] (error: NetworkError?)->() in
            completionHandler(nil, error)
            if let index = self?.requests.index(of: request) {
                self?.requests.remove(at: index)
            }
        }
        request.successBlock = {[weak self] (object: Any?)->() in
            completionHandler(object, nil)
            if let index = self?.requests.index(of: request) {
                self?.requests.remove(at: index)
            }
        }
        request.sendRequestWithSession(session: session)
    }
}
