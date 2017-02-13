//
//  Hero.swift
//  TestingHero
//
//  Created by Miguel Revetria on 10/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Foundation
import Hero

extension HeroModifier {

    static var principleDefaultAnimationCurve: HeroModifier {
        return HeroModifier.timingFunction(CAMediaTimingFunction(controlPoints: 0.25, 0.1, 0.25, 1.0))
    }

}
