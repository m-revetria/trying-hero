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
            let timestamp = "\(Date().timeIntervalSince1970)"

            let params: [(name: String, value: String?)] = [
                (name: "ts", value: timestamp),
                (name: "apikey", value: apiKey),
                (name: "hash", value: "\(timestamp)\(apiSecret)\(apiKey)".md5())
            ]

            _request.url = params.reduce(url) { url, param in
                return url.appendQueryParam(name: param.name, value: param.value)
            }
        }

        return _request
    }

}
