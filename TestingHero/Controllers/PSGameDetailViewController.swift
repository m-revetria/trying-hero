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

        tableView.register(R.nib.pSGameDescriptionTableViewCell)
        tableView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        backgroundImage.image = game.cover
        coverImageView.image = game.cover
        titleLabel.text = game.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

//        backgroundImage.alpha = 0
//        backgroundImage.frame.origin.x = -view.width
//        backgroundImage.motionAnimations = [MotionAnimation.duration(0.5), MotionAnimation.fade(1), MotionAnimation.x(0)]

//        tableView.transform = CGAffineTransform(translationX: 0, y: view.frame.height)
//        tableView.motionAnimations = [.duration(0.5), .translateY(0)]
    }

    @IBAction func backButtonDidTouch(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
//        presentingViewController?.dismiss(animated: true, completion: nil)
    }

}

extension PSGameDetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PSGameDescriptionTableViewCell! = tableView.dequeueReusableCell(withIdentifier: R.nib.pSGameDescriptionTableViewCell)
        cell.textView.text = game.description
        return cell
    }

}

extension PSGameDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width - 40, height: 30))
        backgroundView.backgroundColor = .white
        backgroundView.layer.cornerRadius = 6
        backgroundView.translatesAutoresizingMaskIntoConstraints = false

        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 20))
        view.backgroundColor = .clear
        view.addSubview(backgroundView)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[bkg]-20-|", options: [], metrics: nil, views: ["bkg": backgroundView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-(-10)-[bkg]|", options: [], metrics: nil, views: ["bkg": backgroundView]))

        return view
    }

}
