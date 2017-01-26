//
//  MVPaginatedResponse.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

struct MVPaginatedResponse<T> where T: Decodable, T: OperaDecodable {

    let offset: Int
    let limit: Int
    let total: Int
    let count: Int
    let results: [T]

}

extension MVPaginatedResponse: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVPaginatedResponse {
        return try MVPaginatedResponse(
            offset: json => "offset",
            limit: json => "limit",
            total: json => "total",
            count: json => "count",
            results: json => "results")
    }

}
