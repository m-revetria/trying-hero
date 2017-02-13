//
//  MVEventCollectionViewCell.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Material
import UIKit

class MVEventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var card: Card!

    private(set) weak var eventCardView: MVEventCardView!

    override func awakeFromNib() {
        super.awakeFromNib()
        let eventCardView = MVEventCardView(frame: bounds)
        card.contentView = eventCardView
        self.eventCardView = eventCardView
    }

}
