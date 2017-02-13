//
//  MVEventViewController.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Hero
import RxSwift
import UIKit
import XLSwiftKit

class MVEventViewController: UIViewController {

    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!

    var event: MVEvent!
    var coverImage: UIImage?

    var comics: [MVComic] = []

    fileprivate let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(R.nib.mVEventDetailTableViewCell)
        tableView.rowHeight = 75
        tableView.tableFooterView = UIView()

        MarvelManager.shared.eventComics(eventId: event.id!, limit: 5)
            .subscribe(
                onNext: { [weak self] comics in
                    self?.comics = comics.results
                    self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                },
                onError: { [weak self] error in
                    self?.showError("Oops!", message: error.localizedDescription)
                }
            )
            .addDisposableTo(disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let cover = coverImage {
            coverImageView.image = cover
        } else {
            coverImageView.af_setImage(withURL: event.thumbnail!.url)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)

        if let target = segue.destination as? MVEventComicsViewController {
            target.comics = comics
            target.event = event
        }
    }

    @IBAction func backButtonDidTouch(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }

}

extension MVEventViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MVEventDetailTableViewCell! = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.mVEventDetailCell)

        switch indexPath.row {
        case 0:
            cell.title = "Comics"
            Observable.just(comics)
                .flatMap(Observable.from)
                .flatMap { comic in
                    return comic.image(at: 0)
                        .map { (comic, $0) }
                        .catchError { error in
                            debugPrint(error)
                            return Observable.empty()
                        }
                }
                .toArray()
                .subscribe(
                    onNext: { images in
                        cell.images = images.map { $0.1 }
                        images
                            .map { $0.0 }
                            .enumerated()
                            .forEach { index, comic in
                                cell.imagesStackView.arrangedSubviews[index].heroID = "comic_\(comic.id!)"
                            }
                    }
                )
                .addDisposableTo(cell.disposeBag)
        case 1:
            cell.title = "Characters"
            //cell.images = event.characters.items.prefix(8).map { }
        case 2:
            cell.title = "Stories"
            //cell.images = event.stories.items.map { $0 }
        case 3:
            cell.title = "Creators"
            //cell.images = event.creators.items.map { }
        default:
            break
        }

        return cell
    }

}

extension MVEventViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       performSegue(withIdentifier: "ShowEventComics", sender: self)
    }

}
