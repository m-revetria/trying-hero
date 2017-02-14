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

class PSDashboardViewController: UIViewController {

    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!

    @IBOutlet weak var userActionsContainerView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    @IBOutlet var friendView: UIView!
    @IBOutlet weak var userPictureImageView: UIImageView!
    @IBOutlet weak var userConnectionStatusView: UIView!

    @IBOutlet var blurOverlayView: UIVisualEffectView!

    fileprivate lazy var gamesData: [(title: String, cover: UIImage)] = {
        return [
            (title: "WATCH DOG 2", cover: #imageLiteral(resourceName: "watch_dog")),
            (title: "RESIDENT EVIL 7", cover: #imageLiteral(resourceName: "re7")),
            (title: "FIFA 17", cover: #imageLiteral(resourceName: "fifa17")),
            (title: "DISHONORED 2", cover: #imageLiteral(resourceName: "dishonored")),
            (title: "DOOM", cover: #imageLiteral(resourceName: "doom")),
            (title: "GTA V", cover: #imageLiteral(resourceName: "gtav"))
        ]
    }()

    typealias UserData = (isConnected: Bool, picture: UIImage, name: String)
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

    @IBAction func cancelButtonDidTouch(_ sender: Any) {
        userActionsContainerView.motion(.fade(0), .x(-view.width), .duration(0.35))
        blurOverlayView.motion(.fade(0), .duration(0.35))
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
            gameCell.titleLabel.text = data.title

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
        userPictureImageView.image = data.picture
        nameLabel.text = data.name
        userConnectionStatusView.backgroundColor = data.isConnected ? .green : .lightGray

        blurOverlayView.alpha = 0

        blurOverlayView.motion(.fade(1))

        userActionsContainerView.alpha = 0
        userActionsContainerView.frame = view.frame
        userActionsContainerView.frame.origin.x = -view.width
        view.addSubview(userActionsContainerView)

        friendView.frame = friendsCollectionView.convert(cell.frame, to: view)
        friendView.alpha = 0.0
        view.addSubview(friendView)
        friendView.motion(.fade(1.0), .x(view.center.x), .duration(0.35), .rotationAngleY(360))

        userActionsContainerView.motion(.fade(1.0), .x(0))
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: PSFriendCollectionViewCell! = collectionView.cellForItem(at: indexPath) as? PSFriendCollectionViewCell
        let friendData = friendsData[indexPath.row]
        showOptions(forFriend: friendData, from: cell)
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
