//
//  MVTextObject.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

enum MVTextObjectType: String, Decodable {

    case issueSolicitText = "issue_solicit_text"

}

struct MVTextObject {

    var type: MVTextObjectType
    var language: String
    var text: String

}

extension MVTextObject: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVTextObject {
        return try MVTextObject(
            type: json => "type",
            language: json => "language",
            text: json => "text"
        )
    }

}
