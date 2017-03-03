//
//  PSDashboardViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 13/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Hero
import Material
import UIKit

typealias UserData = (isConnected: Bool, picture: UIImage, name: String)
typealias GameData = (title: String, cover: UIImage, description: String)

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

    fileprivate static let showActionAnimationDuration = 0.3

    fileprivate lazy var gamesData: [GameData] = {
        //swiftlint:disable line_length
        return [
            (title: "WATCH DOG 2", cover: #imageLiteral(resourceName: "watch_dog"), description: "PLAY IT FOR FREE – NOW!\nGain access to 3 hours of gameplay that IGN calls “A Blast To Play!” and fellow PlayStation players have rated 5 – stars! Click the “Try Free Demo” button to start your gaming session today.\n\n\nPlayStation Advantage:\nPlay all Mission Packs 30 days early only on PlayStation. Mission Packs and Season Pass sold separately.\n\nPS4 PRO ENHANCED: \n- Dynamic 4K Gaming\n\nPlay as Marcus Holloway, a brilliant young hacker living in the birthplace of the tech revolution, the San Francisco Bay Area.\n\nTeam up with Dedsec, a notorious group of hackers, and expose the hidden dangers of ctOS 2.0, which, in the hands of corrupt corporations, is being wrongfully used to monitor and manipulate citizens on a massive scale.\n\nSoftware subject to license (us.playstation.com/softwarelicense). Online features require an account and are subject to terms of service and applicable privacy policy (playstationnetwork.com/terms-of-service & playstationnetwork.com/privacy-policy). One-time license fee for play on account’s designated primary PS4™ system and other PS4™ systems when signed in with that account.\n\n©2016 Ubisoft Entertainment. All Rights Reserved. Watch Dogs, Ubisoft and the Ubisoft logo are trademarks of Ubisoft Entertainment in the U.S. and/or other countries.\n·         Explore the dynamic open-world, full of gameplay possibilities.\n·         Hack into every connected device and take control of the city infrastructure.\n·         Develop different skills to suit your playstyle, and upgrade your hacker tools – RC cars, Quadcopter drone, 3D printed weapons and much more."),
            (title: "RESIDENT EVIL 7", cover: #imageLiteral(resourceName: "re7"), description: "Fear and isolation seep through the walls of an abandoned southern farmhouse. '7' marks a new beginning for survival horror with the “Isolated View” of the visceral new first-person perspective. Powered by the RE Engine, horror reaches incredible heights of immersion as players enter a terrifyingly new world of fear as they fight to survive.\n\nVR Games may cause some players to experience motion sickness.\n\nAdditional hardware required for Remote Play.\n\n1 player\nDUALSHOCK®4\nRemote Play\nPlayStation®VR Compatible\n\nSoftware subject to license (us.playstation.com/softwarelicense). Online features require an account and are subject to terms of service and applicable privacy policy (playstationnetwork.com/terms-of-service & playstationnetwork.com/privacy-policy). One-time license fee for play on account’s designated primary PS4™ system and other PS4™ systems when signed in with that account.\n\n©CAPCOM CO., LTD. 2017 ALL RIGHTS RESERVED."),
            (title: "FIFA 17", cover: #imageLiteral(resourceName: "fifa17"), description: "Powered by Frostbite, FIFA 17 transforms the way you play, compete, and emotionally connect with the game.\n\nFIFA 17 immerses you in authentic football experiences by leveraging the sophistication of a new game engine, while introducing you to football players full of depth and emotion, and taking you to brand new worlds accessible only in the game. Complete innovation in the way players think and move, physically interact with opponents, and execute in attack lets you own every moment on the pitch.\n\nAdditional hardware required for Remote Play.\n\nUse of PSN and SEN account are subject to the Terms of Service and User Agreement and applicable privacy policy (see terms at sonyentertainmentnetwork.com/terms-of-service & sonyentertainmentnetwork.com/privacy-policy).\nOnline features may be terminated at any time.\n*Online multiplayer requires a PlayStation®Plus membership.\n\n1-4 players\nNetwork Players 2-22\n44GB minimum save size\nDUALSHOCK®4\nRemote Play\nOnline Play (Optional)\n\nSoftware subject to license (us.playstation.com/softwarelicense). Online features require an account and are subject to terms of service and applicable privacy policy (playstationnetwork.com/terms-of-service & playstationnetwork.com/privacy-policy). One-time license fee for play on account’s designated primary PS4™ system and other PS4™ systems when signed in with that account.\n\nConditions and restrictions apply.  See https://www.easports.com/fifa/game-and-offer-disclaimers for details."),
            (title: "DISHONORED 2", cover: #imageLiteral(resourceName: "dishonored"), description: "Reprise your role as a supernatural assassin in Dishonored 2.\n\nPraised by IGN as “amazing” and “a superb sequel”, declared a “masterpiece” by Eurogamer, and hailed “a must-play revenge tale among the best in its class” by Game Informer, Dishonored 2 is the follow up to Arkane Studio's first-person action blockbuster and winner of more than 100 'Game of the Year' awards, Dishonored.\n\nPlay your way in a world where mysticism and industry collide. Will you choose to play as Empress Emily Kaldwin or the royal protector, Corvo Attano? Will you make your way through the game unseen, make full use of its brutal combat system, or use a blend of both? How will you combine your character's unique set of powers, weapons and gadgets to eliminate your enemies? The story responds to your choices, leading to intriguing outcomes, as you play through each of the game's hand-crafted missions.\n\n1 player\nDUALSHOCK®4\n1080p HD Video Output\n\nSoftware subject to license (us.playstation.com/softwarelicense). Online features require an account and are subject to terms of service and applicable privacy policy (playstationnetwork.com/terms-of-service & playstationnetwork.com/privacy-policy). One-time license fee for play on account’s designated primary PS4™ system and other PS4™ systems when signed in with that account.\n\nDishonored® 2 © 2016 ZeniMax Media Inc. Developed in association with Arkane Studios. Dishonored, Arkane, Bethesda, Bethesda Softworks, ZeniMax and related logos are registered trademarks or trademarks of ZeniMax Media Inc. in the U.S. and/or other countries. All Rights Reserved."),
            (title: "DOOM", cover: #imageLiteral(resourceName: "doom"), description: "Developed by id Software, the studio that pioneered the first-person shooter genre and created multiplayer Deathmatch, DOOM returns as a brutally fun and challenging modern-day shooter experience. Relentless demons, impossibly destructive guns, and fast, fluid movement provide the foundation for intense, first-person combat – whether you’re obliterating demon hordes through the depths of Hell in the single-player campaign, or competing against your friends in numerous multiplayer modes. There is no taking cover or stopping to regenerate health as you beat back Hell’s raging demon hordes. Combine your arsenal of futuristic and iconic guns, upgrades, movement and an advanced melee system to knock-down, slash, stomp, crush, and blow apart demons in creative and violent ways Expand your gameplay experience using the DOOM SnapMap game editor to easily create, play, and share your content with the world.\n\nAdditional hardware required for Remote Play.\n\nUse of PSN and SEN account are subject to the Terms of Service and User Agreement and applicable privacy policy (see terms at sonyentertainmentnetwork.com/terms-of-service & sonyentertainmentnetwork.com/privacy-policy). *Online multiplayer also requires a PlayStation®Plus subscription.\n\n1 player\nNetwork Players 2-12\nDUALSHOCK®4\nRemote Play\n1080p HD Video Output\nOnline Play (Optional)\n\nSoftware subject to license (us.playstation.com/softwarelicense). Online activity subject to Terms of Services and User Agreement (www.playstationnetwork.com/terms-of-service). One-time license fee for play on account’s designated primary PS4™ system and other PS4™ systems when signed in with that account.\n\nDOOM® © 2016 id Software LLC, a ZeniMax Media company. Bethesda, Bethesda Softworks, ZeniMax and related logos are registered trademarks or trademarks of ZeniMax Media Inc. in the U.S. and/or other countries. DOOM, id, id Software, id Tech and related logos are registered trademarks or trademarks of id Software LLC in the U.S. and/or other countries. All Rights Reserved."),
            (title: "GTA V", cover: #imageLiteral(resourceName: "gtav"), description: "HEISTS FOR GRAND THEFT AUTO ONLINE ARE OUT NOW. DOWNLOAD THE AUTOMATIC GRAND THEFT AUTO V TITLE UPDATE TO PLAY NOW.\n\nWhen a young street hustler, a retired bank robber and a terrifying psychopath find themselves entangled with some of the most frightening and deranged elements of the criminal underworld, the U.S. government and the entertainment industry, they must pull off a series of dangerous heists to survive in a ruthless city in which they can trust nobody, least of all each other.\n\nFeatures across-the-board graphical and technical enhancements for a deeper, more vibrant world.\n\nTransfer your existing Grand Theft Auto Online characters and progression to PlayStation®4 system.†\n\nReturning players get exclusive vehicles, weapons, collectibles and more.††\n\nIncludes all Grand Theft Auto Online and Grand Theft Auto V free-to-access content updates.\n\n\n†Player data transfer subject to certain limits and requirements, see rockstargames.com/gtaonline/charactertransfer for details. \n††Access to Exclusive Content requires Rockstar Games Social Club account. Visit rockstargames.com/v/bonuscontent for details.\n\nVideo output in Full HD 1080p requires 1080p native display.\n\nUse of PSN and SEN account are subject to the Terms of Service and User Agreement and applicable privacy policy (see terms at sonyentertainmentnetwork.com/terms-of-service & sonyentertainmentnetwork.com/privacy-policy). *Online multiplayer also requires a PlayStation®Plus subscription.\n\n1 player\nNetwork Players 2-30\nDUALSHOCK®4\n1080p HD Video Output\nOnline Play (Optional)\n\nSoftware subject to license (us.playstation.com/softwarelicense).  Online activity subject to Terms of Services and User Agreement (www.sonyenteretainmentnetwork.com/terms-of-service). One-time license fee for play on account’s designated primary PS4™ system and other PS4™ systems when signed in with that account.\n\nYou must accept the software license terms available at rockstargames.com/eula online account terms at rockstargames.com/socialclub. Non-transferable access to special features such as exclusive/unlockable/downloadable/online content, services, or functions, such as multiplayer services or bonus content, may require single-use serial code, additional fee, and/or online account registration (13+). Access to special features may require internet connection, may not be available to all users or at all times, and may, upon 30 days notice, be terminated, modified, or offered under different terms. Violation of EULA, Code of Conduct, or other policies may result in restriction or termination of access to game or online account. For customer & tech support visit rockstargames.com/support. For information about online services, fees, restrictions, or software license terms that may apply to this game, please visit www.rockstargames.com.\n\nCertain limits apply to purchase, use, and redemption. See EULA www.rockstargames.com/eula and Terms of Service www.rockstargames.com/legal for details.\n\n©2008 - 2014 Rockstar Games, Inc. Rockstar Games, Grand Theft Auto, the GTA Five, and the Rockstar Games R* marks and logos are trademarks and/or registered trademarks of Take-Two Interactive Software, Inc. in the U.S.A. and/or foreign countries.")
        ]
        //swiftlint:enable line_length
    }()

    fileprivate lazy var friendsData: [UserData] = {
        return (0..<12).map { (isConnected: $0 < 3, picture: #imageLiteral(resourceName: "user"), name: "Friend Number \($0)") }
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isHeroEnabled = false

        isHeroEnabled = false
        isMotionEnabled = true

        gamesCollectionView.register(R.nib.pSGameCollectionViewCell)
        friendsCollectionView.register(R.nib.pSFriendCollectionViewCell)

        view.motionIdentifier = "rootView"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        gamesCollectionView.reloadData()
        friendsCollectionView.reloadData()
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

    @IBAction func backButtonDidTouch(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
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
            let gameData = gamesData[indexPath.item]
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
