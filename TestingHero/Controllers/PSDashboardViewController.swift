//
//  PSDashboardViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 13/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Motion
import UIKit

class PSDashboardViewController: UIViewController {

    @IBOutlet weak var gamesCollectionView: UICollectionView!
    @IBOutlet weak var friendsCollectionView: UICollectionView!

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

    fileprivate lazy var friendsData: [(isConnected: Bool, picture: UIImage)] = {
        return [
            (isConnected: true, picture: #imageLiteral(resourceName: "user")),
            (isConnected: true, picture: #imageLiteral(resourceName: "user")),
            (isConnected: true, picture: #imageLiteral(resourceName: "user")),
            (isConnected: false, picture: #imageLiteral(resourceName: "user")),
            (isConnected: false, picture: #imageLiteral(resourceName: "user")),
            (isConnected: false, picture: #imageLiteral(resourceName: "user")),
            (isConnected: false, picture: #imageLiteral(resourceName: "user")),
            (isConnected: false, picture: #imageLiteral(resourceName: "user")),
            (isConnected: false, picture: #imageLiteral(resourceName: "user")),
            (isConnected: false, picture: #imageLiteral(resourceName: "user")),
            (isConnected: false, picture: #imageLiteral(resourceName: "user")),
            (isConnected: false, picture: #imageLiteral(resourceName: "user")),
            (isConnected: false, picture: #imageLiteral(resourceName: "user"))
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        gamesCollectionView.register(R.nib.pSGameCollectionViewCell)
        friendsCollectionView.register(R.nib.pSFriendCollectionViewCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let viewController = segue.destination as? PSUserActionsViewController, let data = sender as? (isConected: Bool, picture: UIImage) {
            viewController.userPictureImageView.image = data.picture
            viewController.userConnectionStatusView.backgroundColor = data.isConecte ? .green : .clear
        }
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


            return friendCell
        }
    }

}

extension PSDashboardViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let friendData = friendsData[indexPath.row]
        performSegue(withIdentifier: R.segue.pSDashboardViewController, sender: friendData)

        let cell: PSFriendCollectionViewCell! = collectionView.cellForItem(at: indexPath) as? PSFriendCollectionViewCell
        cell.imageView.motionIdentifier = "userPicture"
        cell.connectionIndicatorView.motionIdentifier = "userConnectionStatus"
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
