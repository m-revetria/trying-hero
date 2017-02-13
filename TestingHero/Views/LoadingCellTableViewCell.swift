//
//  LoadingCellTableViewCell.swift
//  TestingHero
//
//  Created by Miguel Revetria on 13/2/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import Shimmer
import UIKit

class LoadingCellTableViewCell: UITableViewCell {

    @IBOutlet weak var shimmeringView: FBShimmeringView!
    @IBOutlet weak var shimmeringContentView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        shimmeringView.contentView = shimmeringContentView
        shimmeringView.isShimmering = true
    }

}
