//
//  MVUrl.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

enum MVUrlType: String, Decodable {

    case detail
    case inAppLink
    case purchase
    case reader
    case wiki

}

struct MVTypedUrl {

    let url: URL
    let type: MVUrlType

}

extension MVTypedUrl: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVTypedUrl {
        return try MVTypedUrl(
            url: json => "url",
            type: json => "type"
        )
    }

}
