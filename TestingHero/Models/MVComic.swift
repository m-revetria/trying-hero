//
//  MVComic.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

struct MVComic {

    let resourceUri: URL
    let name: String

}

extension MVComic: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVComic {
        return try MVComic(
            resourceUri: json => "resourceURL",
            name: json => "name"
        )
    }

}
