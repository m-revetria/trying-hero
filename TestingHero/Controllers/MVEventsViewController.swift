//
//  MarvelEventsViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Hero
import RxSwift
import UIKit
import XLSwiftKit

class MVEventsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    fileprivate let disposeBag = DisposeBag()
    fileprivate var events: [MVEvent] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.isHeroEnabled = true

        collectionView.register(R.nib.mVEventCollectionViewCell)
        view.backgroundColor = UIColor(netHex: 0x800c00)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(true, animated: animated)

        MarvelManager.shared.events()
            .subscribe(
                onNext: { [weak self] events in
                    self?.events = events.results
                    self?.collectionView.reloadData()
                },
                onError: { [weak self] error in
                    self?.showError("Oops!", message: error.localizedDescription)
                }
            )
            .addDisposableTo(disposeBag)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let target = segue.destination as? MVEventViewController {
            let data = sender as? (event: MVEvent, image: UIImage?)
            target.event = data?.event
            target.coverImage = data?.image
        }
    }

    @IBAction func backButtonDidTouch(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

}

extension MVEventsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MVEventCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.mVEventCell, for: indexPath)

        cell?.eventCardView.event = events[indexPath.row]

        return cell
    }

}

extension MVEventsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell: MVEventCollectionViewCell! = collectionView.cellForItem(at: indexPath) as? MVEventCollectionViewCell
        let event = events[indexPath.row]

        cell.eventCardView.imageCard.imageView?.heroID = "mv_event_cover"

        performSegue(withIdentifier: R.segue.mVEventsViewController.showEventDetail, sender: (event: event, cover: cell.eventCardView.imageCard.imageView?.image))
    }

}

extension MVEventsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.size
        return CGSize(width: size.width - 20, height: size.height - 20)
    }

}
