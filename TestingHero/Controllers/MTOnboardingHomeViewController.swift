//
//  MTOnboardingHomeViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 20/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Material
import UIKit

class MTOnboardingHomeViewController: UIViewController {

    @IBOutlet weak var animatableBackgroundView: UIView!
    @IBOutlet weak var xlLogo: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        isMotionEnabled = true

        animatableBackgroundView.motionIdentifier = "xlbubble"
        xlLogo.motionIdentifier = "xllogo"

        let duration = MotionAnimation.duration(0.4)
        let timing =  MotionAnimation.timingFunction(.easeInEaseOut)

        animatableBackgroundView.motionAnimations = [duration, timing]
        xlLogo.motionAnimations = [duration, timing]

        tableView.motion(.duration(0.0), .translateY(view.frame.height))
        tableView.rowHeight = 212
        tableView.register(R.nib.loadingCellTableViewCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        tableView.motion(.delay(0.52), .duration(0.35), .translateY(0), .timingFunction(.easeInEaseOut))
    }

    @IBAction func backButtonDidTouch(_ sender: Any) {
        _ = navigationController?.popToRootViewController(animated: true)
    }

}

extension MTOnboardingHomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell! = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.loadingCell)

        cell.motion(.fade(0), .duration(0.0), .translateY(200))
        cell.motion(.fade(1), .duration(0.30), .delay(1 + 0.1 * Double(indexPath.row)), .translateY(0))

        return cell

    }

}

extension MTOnboardingHomeViewController: UITableViewDelegate {

}
