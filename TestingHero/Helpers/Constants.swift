//
//  Constants.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Foundation
import UIKit

struct Constants {

    struct Formatters {

        static let iso8601Formatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
            return formatter
        }()

        static let longDateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.dateFormat = "yyyy MMM, EEE d"
            return formatter
        }()

    }

    struct Networking {

        static let marvelBaseUrl: URL! = URL(string: "https://gateway.marvel.com/v1/public")
        static let paginatedRequestsSize = 20

    }

}
