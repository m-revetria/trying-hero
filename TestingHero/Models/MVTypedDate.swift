//
//  MVTypedDate.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

enum MVDateType: String, Decodable {

    case digitalPurchaseDate
    case focDate
    case onsaleDate
    case unlimitedDate

}

// Used to extend Array where Iterator.Element: MVTypedDate
protocol MVTypedDateProtocol {

    var date: Date? { get set }
    var type: MVDateType { get set }

}

struct MVTypedDate: MVTypedDateProtocol {

    var date: Date?
    var type: MVDateType

}

extension MVTypedDate: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVTypedDate {
        let dateDecoder: (Any) throws -> Date = Date.decoder(using: Constants.Formatters.iso8601Formatter)
        let date: Date? = try? dateDecoder(json => "date")
        return try MVTypedDate(
            date: date,
            type: json => "type"
        )
    }

}

extension Sequence where Iterator.Element: MVTypedDateProtocol {

    func first(withType type: MVDateType) -> MVTypedDateProtocol? {
        return self.first { $0.type.rawValue == type.rawValue }
    }

}
