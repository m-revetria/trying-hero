//
//  MVResponse.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

struct MVResponse<T> where T: Decodable, T: OperaDecodable {

    let code: Int
    let status: String
    let etag: String
    let data: T

}

extension MVResponse: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVResponse {
        return try MVResponse(
            code: json => "code",
            status: json => "status",
            etag: json => "etag",
            data: json => "data"
        )
    }

}
