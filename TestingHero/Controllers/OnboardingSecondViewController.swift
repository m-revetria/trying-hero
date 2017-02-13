//
//  OnboardingSecondViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 10/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Hero
import UIKit

class OnboardingSecondViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.async { [weak self] in
            self?.performSegue(withIdentifier: R.segue.onboardingSecondViewController.showHomeView, sender: self)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        Hero.shared.setDefaultAnimationForNextTransition(.fade)
    }

}
