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

enum MVStoryType: String, Decodable {

    case cover = "cover"
    case credits = "credits"
    case interiorStory = "interiorStory"
    case none = ""
    case profile = "profile"
    case promo = "promo"
    case pinup = "pinup"
    case tableOfContent = "table of contents"
    case textArticle = "text article"

}

struct MVStory {

    let resourceUri: String
    let name: String
    let type: MVStoryType

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
