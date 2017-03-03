//
//  MVEventDetailTableViewCell.swift
//  TestingHero
//
//  Created by Miguel Revetria on 27/1/17.
//  Copyright © 2017 Xmartlabs. All rights reserved.
//

import RxSwift
import UIKit

class MVEventDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var imagesStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!

    var disposeBag = DisposeBag()

    var images: [UIImage] = [] {
        didSet {
            setupImages(images: images)
        }
    }

    var title: String! {
        didSet {
            titleLabel?.text = title
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        setupImages(images: images)
        titleLabel.text = title
        titleLabel.heroModifiers = [.zPosition(99)]
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        // Dispose any observable attached to this cell
        disposeBag = DisposeBag()
    }

    private func setupImages(images: [UIImage]) {
        guard let stack = imagesStackView else {
            return
        }

        stack.arrangedSubviews.forEach {
            stack.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }

        UIView.animate(withDuration: 0.25) {
            images.forEach { image in
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 75, height: 75))
                imageView.addConstraints(
                    NSLayoutConstraint.constraints(withVisualFormat: "H:[image(75)]", options: [], metrics: nil, views: ["image": imageView])
                )
                imageView.image = image
                stack.addArrangedSubview(imageView)
            }

        }
    }

}
