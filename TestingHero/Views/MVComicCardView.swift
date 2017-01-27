//
//  MVComicCardView.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Material
import UIKit
import XLSwiftKit

class MVComicCardView: OwnerView {

    private(set) var mainCardView: PresenterCard!
    private(set) var toolbar: Toolbar!
    private(set) var imageView: UIImageView!
    private(set) var descriptionLabel: UILabel!
    private(set) var dateLabel: UILabel!

    var comic: MVComic! {
        didSet {
            guard let comic = comic else {
                return
            }

            refresh(with: comic)
        }
    }

    var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    override func viewForContent() -> UIView? {
        // customization point
        mainCardView = PresenterCard()
        mainCardView.backgroundColor = .white

        toolbar = Toolbar(frame: CGRect(x: 0, y: 0, width: frame.width, height: 44))
        toolbar.titleLabel.font = RobotoFont.regular(with: 13)
        toolbar.titleLabel.lineBreakMode = .byTruncatingTail
        toolbar.titleLabel.numberOfLines = 2
        toolbar.titleLabel.textAlignment = .left

        mainCardView.toolbar = toolbar
        mainCardView.toolbarEdgeInsetsPreset = .wideRectangle2

        imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: frame.width, height: 180))
        mainCardView.presenterView = imageView

        descriptionLabel = UILabel()
        descriptionLabel.font = RobotoFont.regular(with: 10)
        descriptionLabel.lineBreakMode = .byTruncatingTail
        descriptionLabel.numberOfLines = 3
        descriptionLabel.textColor = .black

        mainCardView.contentView = descriptionLabel
        mainCardView.contentViewEdgeInsetsPreset = .square1

        dateLabel = UILabel()
        dateLabel.font = .systemFont(ofSize: 9)
        dateLabel.textAlignment = .center
        dateLabel.textColor = .gray

        toolbar.title = "Age of Ultron"

        return mainCardView
    }

    override func setup() {
        super.setup()
    }

    private func refresh(with comic: MVComic) {
        toolbar.title = comic.title ?? "N/A"
        if let texts = comic.textObjects, let text = texts.first?.text {
            descriptionLabel.attributedText = text.attributedStringFromHtml()
        }
    }

}
