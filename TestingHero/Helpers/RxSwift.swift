//
//  RxSwift.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Foundation
import RxSwift

extension Observable {

    static func from(elements: [Element]) -> Observable<Element> {
        return Observable.create() { observer in
            elements.forEach() {
                observer.onNext($0)
            }
            observer.onCompleted()

            return Disposables.create()
        }
    }
    
}
