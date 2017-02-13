//
//  PSGameCollectionViewCell.swift
//  TestingHero
//
//  Created by Miguel Revetria on 13/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import UIKit

class PSGameCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var labelBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.black.withAlphaComponent(0.0).cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        labelBackgroundView.layer.addSublayer(gradientLayer)
    }

}
