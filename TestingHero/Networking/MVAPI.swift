//
//  MVAPI.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Foundation
import Opera

protocol MarvelAPI {

}

extension RouteType where Self: MarvelAPI {

    var baseURL: URL { return Constants.Networking.marvelBaseUrl }
    
}

extension API {

    struct Marvel {

    }

}

extension API.Marvel {

    struct Events {

        struct List: GetRouteType, MarvelAPI {

            let path = "events"

        }

    }

}
