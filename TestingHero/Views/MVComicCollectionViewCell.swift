//
//  MVComicCollectionViewCell.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import RxSwift
import UIKit

class MVComicCollectionViewCell: UICollectionViewCell {

    private(set) var disposeBag = DisposeBag()

    @IBOutlet weak var comicCardView: MVComicCardView!

    var comic: MVComic! {
        didSet {
            comicCardView.comic = comic

            disposeBag = DisposeBag()
            comic.image()
                .subscribe(
                    onNext: { [weak self] image in
                        self?.comicCardView.image = image
                    },
                    onError: { error in
                        debugPrint(error)
                    }
                )
                .addDisposableTo(disposeBag)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

}
