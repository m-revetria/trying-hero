//
//  MTOnboardingStartViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 20/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Material
import UIKit

class MTOnboardingStartViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var xlLogo: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var readyLabel: UILabel!
    @IBOutlet var labels: [UILabel]!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isHeroEnabled = false

        isHeroEnabled = false
        isMotionEnabled = true

        xlLogo.motionIdentifier = "xllogo"
        containerView.motionIdentifier = "xlbubble"

        readyLabel.motion(.duration(0.0), .fade(0))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    @IBAction func startButtonDidTouch(_ sender: Any) {
        firstAnimationBlock()
        secondAnimationBlock()
        thirdAnimationBlock()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.23 + 0.28) { [unowned self] in
            self.performSegue(withIdentifier: R.segue.mTOnboardingStartViewController.showHomeDashboard, sender: self)
        }
    }

    private func firstAnimationBlock() {
        let duration = MotionAnimation.duration(0.30)
        let timing = MotionAnimation.timingFunction(.easeInEaseOut)

        labels.forEach { lbl in
            lbl.motion(duration, .translateY(30), .fade(0), timing)
        }
        startButton.motion(duration, .translateY(30), .fade(0), timing)
    }

    private func secondAnimationBlock() {
        let delay = MotionAnimation.delay(0.18)
        let duration = MotionAnimation.duration(0.52)
        let timing = MotionAnimation.timingFunction(.easeInEaseOut)

        let translationX = view.center.x - xlLogo.center.x
        let translationY = view.center.y - xlLogo.center.y
        xlLogo.motion(delay, duration, .translateX(translationX), .translateY(translationY), timing)

        containerView.motion(delay, duration, .size(width: 195, height: 195), timing, .cornerRadius(195 * 0.5))
    }

    private func thirdAnimationBlock() {
        let delay = MotionAnimation.delay(0.93)
        let duration = MotionAnimation.duration(0.30)

        readyLabel.motion(delay, duration, .fade(1), .translateY(-40))
    }

    @IBAction func backButtonDidTouch(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

}
