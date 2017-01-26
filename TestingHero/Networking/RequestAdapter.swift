//
//  RequestAdapter.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Alamofire
import Foundation

class RequestAdapter: Alamofire.RequestAdapter {

    let apiKey = "a260fb403690ea40dcbf15aac1ae666a"
    let apiSecret = "b6c176a0d0fa43bf5291039db0ba7a42c4d83705"

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var _request = urlRequest

        if let url = _request.url, url.absoluteString.hasPrefix(Constants.Networking.marvelBaseUrl.absoluteString) {
            var components = URLComponents(string: url.absoluteString)

            let timestamp = "\(Date().timeIntervalSince1970)"
            components?.queryItems = [
                URLQueryItem(name: "ts", value: timestamp),
                URLQueryItem(name: "apikey", value: apiKey),
                URLQueryItem(name: "hash", value: "\(timestamp)\(apiSecret)\(apiKey)".md5())
            ]

            _request.url = components?.url
        }

        return _request
    }

}
