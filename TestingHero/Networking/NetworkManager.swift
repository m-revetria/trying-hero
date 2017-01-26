//
//  NetworkManager.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Alamofire
import Opera
import RxSwift

struct API { }

class NetworkManager: RxManager {

    static let singleton = NetworkManager(manager: Alamofire.SessionManager.default)

    override init(manager: Alamofire.SessionManager) {
        super.init(manager: manager)
        manager.adapter = RequestAdapter()
        observers = [Logger()]
    }

}

struct Logger: Opera.ObserverType {

    func willSendRequest(_ alamoRequest: Alamofire.Request, requestConvertible: URLRequestConvertible) {
        debugPrint(alamoRequest)
    }

}
