//
//  MarvelManager.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Decodable
import Foundation
import Opera
import RxSwift

class MarvelManager {

    static let shared = MarvelManager()

    private init() {

    }

    fileprivate func extractData<T>(fromResponse response: MVResponse<T>) -> T where T: Decodable, T: OperaDecodable {
        return response.data
    }

}

extension MarvelManager {

    func events() -> Observable<MVPaginatedResponse<MVEvent>> {
        return API.Marvel.Events.List()
            .rx_object()
            .map(extractData)
    }

}
