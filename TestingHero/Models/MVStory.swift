//
//  MVStory.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

enum MVStoryCover: String, Decodable {

    case cover = "cover"
    case interiorStory = "interiorStory"
    case none = ""

}

struct MVStory {

    let resourceUri: String
    let name: String
    let type: MVStoryCover

}

extension MVStory: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVStory {
        return try MVStory(
            resourceUri: json => "resourceURI",
            name: json => "name",
            type: json => "type"
        )
    }

}
