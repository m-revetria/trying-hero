//
//  URL.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation

extension URL: Decodable, DynamicDecodable {

    public static var decoder: (Any) throws -> URL = { value in
        let string = try String.decode(value)
        guard let result = URL(string: string) else {
            let metadata = DecodingError.Metadata(object: value)
            throw DecodingError.typeMismatch(expected: URL.self, actual: String.self, metadata)
        }
        return result
    }

    public func appendQueryParam(name: String, value: String?) -> URL {
        var components = URLComponents(string: absoluteString)!
        if components.queryItems == nil {
            components.queryItems = []
        }
        components.queryItems?.append(URLQueryItem(name: name, value: value))
        return components.url!
    }

}
