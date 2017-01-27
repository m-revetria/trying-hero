//
//  MVEventComicsViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Hero
import UIKit
import RxSwift

class MVEventComicsViewController: UIViewController {

    var event: MVEvent!
    var comics: [MVComic] = []

    fileprivate let disposeBag = DisposeBag()

    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(R.nib.mVComicCollectionViewCell)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        MarvelManager.shared.eventComics(eventId: event.id!)
            .subscribe(
                onNext: { [weak self] comics in
                    self?.comics = comics.results
                    self?.collectionView.reloadData()
                },
                onError: { [weak self] error in
                    self?.showError("Oops!", message: error.localizedDescription)
                }
            )
            .addDisposableTo(disposeBag)
    }

    @IBAction func backButtonDidTouch(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

}

extension MVEventComicsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MVComicCollectionViewCell! = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.mVComicCollectionViewCell, for: indexPath)

        let comic = comics[indexPath.item]

        cell.comic = comic
        cell.heroID = "comic_\(comic.id!)"
        cell.heroModifiers = [.fade, .scale(0.5)]

        return cell
    }

}

extension MVEventComicsViewController: UICollectionViewDelegate {

}

extension MVEventComicsViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CGFloat(collectionView.bounds.width * 0.5)
        return CGSize(width: width, height: 320)
    }

}
