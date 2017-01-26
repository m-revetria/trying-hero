//
//  MVCharacter.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

struct MVCharacter {

    let resourceUri: URL
    let name: String

}

extension MVCharacter: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVCharacter {
        return try MVCharacter(
            resourceUri: json => "resourceURI",
            name: json => "name"
        )
    }

}
