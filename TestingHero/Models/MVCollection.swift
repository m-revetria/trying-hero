//
//  MVCollection.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

struct MVCollection<T> where T: Decodable, T: OperaDecodable {

    let available: Int
    let collectionUri: URL
    let items: [T]

}

extension MVCollection: Decodable, OperaDecodable {

    static func decode<T>(_ json: Any) throws -> MVCollection<T> {
        return try MVCollection<T>(
            available: json => "available",
            collectionUri: json => "collectionURI",
            items: json => "items"
        )
    }

}
