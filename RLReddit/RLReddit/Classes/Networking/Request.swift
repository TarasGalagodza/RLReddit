//
//  Request.swift
//  RLReddit
//
//  Created by Taras Galagodza on 8/16/17.
//  Copyright © 2017 Taras Galagodza. All rights reserved.
//

import UIKit

typealias PCRequestFailureBlock = (NetworkError?)-> Void
typealias PCRequestSuccessBlock = (Any?)-> Void

enum NetworkError: Error {
    case systemError
    case wrongResponseFormat
    case failedToParseResponse
}

class Request {
    static let baseURL = "https://www.reddit.com/"
    private var url : URL
    private var dataTask : URLSessionDataTask?
    var successBlock : PCRequestSuccessBlock?
    var failureBlock : PCRequestFailureBlock?
    
    init(url: URL){
        self.url = url
    }

    func cancelRequest() {
        if let dataTask = dataTask {
            dataTask.cancel()
        }
    }
    
    func sendRequestWithSession(session: URLSession) {

        let request = URLRequest(url: url)
        dataTask = session.dataTask(with: request) { [weak self] data, response, error in
            
            var networkError: NetworkError? = nil
            defer {
                if let networkError = networkError, let failureBlock = self?.failureBlock {
                    DispatchQueue.main.async {
                        failureBlock(networkError)
                    }
                }
            }
            
            if error != nil {
                networkError = .systemError
                return
            }
            
            guard let data = data else {
                networkError = .wrongResponseFormat
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                if let parseResult = self?.parse(json: json)
                {
                    DispatchQueue.main.async {
                        if let successBlock = self?.successBlock {
                            DispatchQueue.main.async {
                                successBlock(parseResult)
                            }
                        }
                    }
                }
                else {
                    networkError = .failedToParseResponse
                }
            } catch {
                networkError = .failedToParseResponse
            }
        }
        dataTask?.resume()
    }

    func parse(json: Any) -> Any? {
        return nil;
    }
}
