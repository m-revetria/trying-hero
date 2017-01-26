//
//  Event.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

struct MVEvent {

    let id: Int
    let title: String
    let description: String
    let resourceUri: URL
    let urls: [MVTypedUrl]
    let start: Date
    let end: Date
    let thumbnail: MVImage
    let creators: MVCollection<MVCreator>
    let characters: MVCollection<MVCharacter>
    let stories: MVCollection<MVStory>
    let comics: MVCollection<MVComic>

}

extension MVEvent: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVEvent {
        return try MVEvent(
            id: json => "id",
            title: json => "title",
            description: json => "description",
            resourceUri: json => "resourceURI",
            urls: json => "urls",
            start: json => "start",
            end: json => "end",
            thumbnail: json => "thumbnail",
            creators: json => "creators",
            characters: json => "characters",
            stories: json => "stories",
            comics: json => "comics")
    }

}
