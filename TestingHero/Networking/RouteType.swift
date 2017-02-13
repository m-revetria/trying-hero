//
//  RouteType.swift
//  TestingHero
//
//  Created by Miguel Revetria on 26/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Alamofire
import Foundation
import Opera

extension RouteType {

    var manager: ManagerType { return NetworkManager.singleton  }
    var retryCount: Int { return 0 }

}

// MARK: - GetRouteType

protocol GetRouteType: RouteType { }

extension GetRouteType {

    var method: HTTPMethod {
        return .get
    }

}

// MARK: - PostRouteType

protocol PostRouteType: RouteType { }

extension PostRouteType {

    var method: HTTPMethod {
        return .post
    }

}

// MARK: - DeleteRouteType
protocol DeleteRouteType: RouteType { }

extension DeleteRouteType {

    var method: HTTPMethod {
        return .delete
    }

}
