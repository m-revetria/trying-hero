//
//  MVEventTableViewCell.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import AlamofireImage
import Material
import UIKit
import XLSwiftKit

class MVEventCardView: OwnerView {

    private(set) var imageCard: ImageCard!

    var event: MVEvent? {
        didSet {
            guard let event = event else {
                return
            }

            refresh(withEvent: event)
        }
    }

    override func viewForContent() -> UIView? {
        imageCard = ImageCard(frame: bounds)

        imageCard.imageView = UIImageView(frame: imageCard.bounds)
        imageCard.imageView?.frame = imageCard.frame
        imageCard.imageView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageCard.imageView?.backgroundColor = UIColor.darkGray

        /*
        imageCard.toolbar = Toolbar()
        imageCard.toolbar?.backgroundColor = .clear
        imageCard.toolbar?.titleLabel.textColor = .white
        imageCard.toolbar?.detailLabel.textColor = .white
        imageCard.toolbarEdgeInsetsPreset = .square3
        */

        return imageCard
    }

    override func setup() {
        super.setup()
    }

    override func layoutSubviews() {
        imageCard.imageView?.frame = frame
        super.layoutSubviews()
    }

    private func refresh(withEvent event: MVEvent) {
        imageCard.toolbar?.title = event.title
        imageCard.toolbar?.detail = event.description
        imageCard.imageView?.af_setImage(withURL: event.thumbnail!.url)
    }

}
