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
    case other = "other"
    case penciler = "penciler"
    case pencilerCover = "penciler (cover)"
    case writer = "writer"

    init?(rawValue: String) {
        // We must normalize the rawValue got from server:
        //    * Colorist = colorist
        //    * penciller = penciler
        //    * penciller (cover) = penciler (cover)
        let value = rawValue.lowercased()
            .replacingOccurrences(of: "penciller", with: "penciler")
        switch value {
        case MVCreatorRole.artist.rawValue:
            self = MVCreatorRole.artist
        case MVCreatorRole.colorist.rawValue:
            self = MVCreatorRole.colorist
        case MVCreatorRole.editor.rawValue:
            self = MVCreatorRole.editor
        case MVCreatorRole.inker.rawValue:
            self = MVCreatorRole.inker
        case MVCreatorRole.letterer.rawValue:
            self = MVCreatorRole.letterer
        case MVCreatorRole.other.rawValue:
            self = MVCreatorRole.other
        case MVCreatorRole.penciler.rawValue:
            self = MVCreatorRole.penciler
        case MVCreatorRole.pencilerCover.rawValue:
            self = MVCreatorRole.pencilerCover
        case MVCreatorRole.writer.rawValue:
            self = MVCreatorRole.writer
        default:
            return nil
        }
    }

}

struct MVCreator {

    let resourceURI: URL
    let name: String
    let role: MVCreatorRole

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
