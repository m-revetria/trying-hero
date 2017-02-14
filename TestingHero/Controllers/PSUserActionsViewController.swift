//
//  PSUserActionsViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 14/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Motion
import UIKit

class PSUserActionsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    @IBOutlet weak var userPictureImageView: UIImageView!
    @IBOutlet weak var userConnectionStatusView: UIView!

    @IBOutlet weak var contentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        contentView.motionAnimations = [.translateX(375)]
        userPictureImageView.motionIdentifier = "userPicture"
        userConnectionStatusView.motionIdentifier = "userConnectionStatus"
    }

}
