//
//  OnboardingStartViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 10/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Hero
import UIKit

class OnboardingStartViewController: UIViewController {

    @IBOutlet var labels: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        Hero.shared.setDefaultAnimationForNextTransition(.fade)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func backButtonDidTouch(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

}
