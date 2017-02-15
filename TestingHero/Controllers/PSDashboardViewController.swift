//
//  PSDashboardViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 13/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Hero
import Motion
import UIKit

typealias UserData = (isConnected: Bool, picture: UIImage, name: String)
typealias GameData = (title: String, cover: UIImage)

class PSDashboardViewController: UIViewController {

    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!

    @IBOutlet var blurringContainerView: UIView!
    @IBOutlet weak var blurringView: UIVisualEffectView!

    @IBOutlet weak var userActionsContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    @IBOutlet var friendView: UIView!
    @IBOutlet weak var userPictureImageView: UIImageView!
    @IBOutlet weak var userConnectionStatusView: UIView!

    var hideFriendActions: ((Void) -> Void)?

    fileprivate static let showActionAnimationDuration = 0.5

    fileprivate lazy var gamesData: [GameData] = {
        return [
            (title: "WATCH DOG 2", cover: #imageLiteral(resourceName: "watch_dog")),
            (title: "RESIDENT EVIL 7", cover: #imageLiteral(resourceName: "re7")),
            (title: "FIFA 17", cover: #imageLiteral(resourceName: "fifa17")),
            (title: "DISHONORED 2", cover: #imageLiteral(resourceName: "dishonored")),
            (title: "DOOM", cover: #imageLiteral(resourceName: "doom")),
            (title: "GTA V", cover: #imageLiteral(resourceName: "gtav"))
        ]
    }()

    fileprivate lazy var friendsData: [UserData] = {
        return (0..<12).map { (isConnected: $0 < 3, picture: #imageLiteral(resourceName: "user"), name: "Friend Number \($0)") }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        isHeroEnabled = false
        isMotionEnabled = true

        gamesCollectionView.register(R.nib.pSGameCollectionViewCell)
        friendsCollectionView.register(R.nib.pSFriendCollectionViewCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let viewController = segue.destination as? PSGameDetailViewController, let data = sender as? GameData {
            viewController.game = data
        }
    }

    @IBAction func cancelButtonDidTouch(_ sender: Any) {
        hideFriendActions?()
    }

}

extension PSDashboardViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.gamesCollectionView {
            return gamesData.count
        } else {
            return friendsData.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.gamesCollectionView {
            let gameCell: PSGameCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.pSGameCell, for: indexPath)

            let data = gamesData[indexPath.item]
            gameCell.imageView.image = data.cover
            gameCell.imageView.motionIdentifier = ""
            gameCell.titleLabel.text = data.title
            gameCell.titleLabel.motionIdentifier = ""

            return gameCell
        } else {
            let friendCell: PSFriendCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.pSFriendCell, for: indexPath)

            let data = friendsData[indexPath.item]
            friendCell.imageView.image = data.picture
            friendCell.connectionIndicatorView.backgroundColor = data.isConnected
                    ? .green
                    : .lightGray
            friendCell.connectionIndicatorView.layer.shadowColor = data.isConnected
                ? UIColor.green.withAlphaComponent(0.55).cgColor
                : UIColor.clear.cgColor

            friendCell.imageView.motionIdentifier = ""
            friendCell.connectionIndicatorView.motionIdentifier = ""

            return friendCell
        }
    }

}

extension PSDashboardViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private func showOptions(forFriend data: UserData, from cell: PSFriendCollectionViewCell) {
        let duration = PSDashboardViewController.showActionAnimationDuration
        let noduration = 0.0
        let timingFunction = MotionAnimation.timingFunction(.easeIn)

        userPictureImageView.image = data.picture
        nameLabel.text = data.name
        userConnectionStatusView.backgroundColor = data.isConnected ? .green : .lightGray

        blurringView.alpha = 0
        view.addSubview(blurringContainerView)

        userActionsContainerView.alpha = 0
        userActionsContainerView.frame = view.frame
        userActionsContainerView.frame.origin.x = -view.width
        view.addSubview(userActionsContainerView)

        friendView.frame = friendsCollectionView.convert(cell.frame, to: view)
        view.addSubview(friendView)

        cell.alpha = 0

        blurringContainerView.motion(.duration(noduration), .fade(1))
        friendView.motion(.duration(noduration), .fade(1))

        blurringView.motion(.duration(duration), .fade(1), timingFunction)
        friendView.motion(.duration(duration), .translateX(view.center.x - friendView.center.x), timingFunction)
        userActionsContainerView.motion(.duration(duration), .fade(1.0), .x(0), timingFunction)
        userPictureImageView.motion(.duration(duration), .rotationAngleZ(360), timingFunction)

        hideFriendActions = { [unowned self] in
            self.blurringView.motion(.duration(duration), .fade(0), timingFunction)
            self.blurringContainerView.motion(.delay(duration), .duration(noduration), .fade(0))
            self.friendView.motion(.duration(duration), .translateX(0), timingFunction)
            self.friendView.motion(.delay(duration), .duration(noduration), .fade(0))
            self.userActionsContainerView.motion(.duration(duration), .fade(0), .x(-self.view.width), timingFunction)
            self.userPictureImageView.motion(.duration(duration), .rotationAngleZ(360), timingFunction)
            cell.motion(.delay(duration), .duration(noduration), .fade(1))
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == friendsCollectionView {
            let cell: PSFriendCollectionViewCell! = collectionView.cellForItem(at: indexPath) as? PSFriendCollectionViewCell
            let friendData = friendsData[indexPath.item]
            showOptions(forFriend: friendData, from: cell)
        } else {
            let cell: PSGameCollectionViewCell! = collectionView.cellForItem(at: indexPath) as? PSGameCollectionViewCell
            cell.imageView.motionIdentifier = "gameCover"
            cell.titleLabel.motionIdentifier = "gameTitle"
            let gameData = friendsData[indexPath.item]
            performSegue(withIdentifier: R.segue.pSDashboardViewController.showGameDetail, sender: gameData)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.gamesCollectionView {
            return CGSize(width: 136, height: 180)
        } else {
            return CGSize(width: 64, height: 74)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

}
