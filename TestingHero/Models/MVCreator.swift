//
//  MVCreator.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

enum MVCreatorRole: String, Decodable {

    case artist = "artist"
    case colorist = "colorist"
    case editor = "editor"
    case inker = "inker"
    case letterer = "letterer"
    case penciler = "penciler"
    case penciller = "penciller"
    case pencillerCover = "penciller (cover)"
    case writer = "writer"

}

struct MVCreator {

    let resourceURI: URL
    let name: String
    let role: MVCreatorRole!

}

extension MVCreator: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVCreator {
        return try MVCreator(
            resourceURI: json => "resourceURI",
            name: json => "name",
            role: json => "role"
        )
    }

}
