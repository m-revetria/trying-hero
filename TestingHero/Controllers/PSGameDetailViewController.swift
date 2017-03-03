//
//  PSGameDetailViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 15/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Material
import UIKit

class PSGameDetailViewController: UIViewController {

    var game: GameData!

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var animatableCoverImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.setImage(#imageLiteral(resourceName: "Back").withRenderingMode(.alwaysTemplate), for: .normal)
        backButton.tintColor = .white

        isMotionEnabled = true
        animatableCoverImageView.motionIdentifier = "gameCover"
        backgroundImage.motion(.duration(0.0), .translateX(-view.frame.width))
        tableView.motion(.duration(0.0), .translateY(view.frame.height))

        coverImageView.alpha = 0.0

        tableView.register(R.nib.pSGameDescriptionTableViewCell)
        tableView.contentInset = UIEdgeInsets(top: 150, left: 0, bottom: 0, right: 0)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200

        animatableCoverImageView.image = game.cover
        backgroundImage.image = game.cover
        coverImageView.image = game.cover
        titleLabel.text = game.title
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let duration = 0.3
        let delay = 0.30
        let timing = MotionAnimation.timingFunction(.easeInEaseOut)

        backgroundImage.motion(.delay(delay), .duration(duration), .translateX(0), timing)
        tableView.motion(.delay(delay), .duration(duration), .translateY(0), timing)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) { [unowned self] in
            self.animatableCoverImageView.alpha = 0.0
            self.coverImageView.alpha = 1.0
        }
    }

    @IBAction func backButtonDidTouch(_ sender: Any) {
        animatableCoverImageView.alpha = 1
        coverImageView.alpha = 0

        let duration = 0.25
        let delay = 0.25
        let timing = MotionAnimation.timingFunction(.easeInEaseOut)

        backgroundImage.motion([.duration(duration), .translateX(-view.frame.width), timing])
        tableView.motion([.duration(duration), .translateY(view.frame.height), timing])

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [unowned self] in
            _ = self.navigationController?.popViewController(animated: true)
        }
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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        tableView.convert(cell!.frame, to: view)
        debugPrint()
    }

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
