//
//  MVImage.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera

struct MVImage {

    let path: String
    let `extension`: String

    var url: URL! {
        return URL(string: "\(path).\(`extension`)")
    }

}

extension MVImage: Decodable, OperaDecodable {

    static func decode(_ json: Any) throws -> MVImage {
        return try MVImage(
            path: json => "path",
            extension: json => "extension"
        )
    }

}
