//
//  NavigationViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Hero
import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        isHeroEnabled = false
        isMotionEnabled = true
    }

    override var prefersStatusBarHidden: Bool {
        return topViewController?.prefersStatusBarHidden ?? false
    }

    override var statusBarStyle: UIStatusBarStyle {
        get { return topViewController?.preferredStatusBarStyle ?? .default }
        set { }
    }

}
