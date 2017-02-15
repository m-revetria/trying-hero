//
//  PSGameDetailViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 15/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Motion
import UIKit

class PSGameDetailViewController: UIViewController {

    var game: GameData!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.setImage(#imageLiteral(resourceName: "Back").withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .white

        isMotionEnabled = true

        coverImageView.motionIdentifier = "gameCover"
        titleLabel.motionIdentifier = "gameTitle"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonDidTouch(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

}
