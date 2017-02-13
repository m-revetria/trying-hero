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

protocol MVPaginatedRouteType: GetRouteType, MarvelAPI, URLRequestSetup {

    var limit: Int { get }
    var offset: Int { get }

}

extension MVPaginatedRouteType {

    var limit: Int {
        return Constants.Networking.paginatedRequestsSize
    }

    func urlRequestSetup(_ urlRequest: inout URLRequest) {
        if let url = urlRequest.url {
            let params: [(String, String)] = [
                ("limit", "\(limit)"),
                ("offset", "\(offset)")
            ]
            urlRequest.url = params.reduce(url) { url, param in
                return url.appendQueryParam(name: param.0, value: param.1)
            }
        }
    }

}

extension API {

    struct Marvel {

    }

}

// MARK: - Events

extension API.Marvel {

    struct Events {

    }

}

extension API.Marvel.Events {

    struct List: MVPaginatedRouteType, MarvelAPI {

        let offset: Int = 0

        var path: String {
            return "events"
        }

    }

    struct Comics: MVPaginatedRouteType, MarvelAPI {

        let eventId: Int
        var limit: Int = Constants.Networking.paginatedRequestsSize
        var offset: Int = 0

        var path: String {
            return "events/\(eventId)/comics"
        }

        var parameters: [String : Any]? {
            return [
                "orderBy": "onsaleDate"
            ]
        }

    }

}

// MARK: Comics

extension API.Marvel {

    struct Comics {

    }

}

extension API.Marvel.Comics {

    struct Get: GetRouteType, MarvelAPI {

        let resourceUri: String?
        let id: Int?

        var path: String {
            if let uri = resourceUri {
                return uri.replacingOccurrences(of: Constants.Networking.marvelBaseUrl.absoluteString, with: "")
            } else {
                return "comics/\(id)"
            }
        }

        init(resourceUri: String) {
            self.id = nil
            self.resourceUri = resourceUri
        }

        init(id: Int) {
            self.id = id
            self.resourceUri = nil
        }

    }

}
