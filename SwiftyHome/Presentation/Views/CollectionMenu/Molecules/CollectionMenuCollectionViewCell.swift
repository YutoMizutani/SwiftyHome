//
//  CollectionMenuCollectionViewCell.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

class CollectionMenuCollectionViewCell: UICollectionViewCell, NibLoadable {
    @IBOutlet weak var imageView: CollectionMenuContentImageView!
    @IBOutlet weak var descriptionView: CollectionMenuContentView!

    override func prepareForReuse() {
        super.prepareForReuse()
        reuseView()
    }

    private func reuseView() {
        imageView.reuseView()
        descriptionView.reuseView()
    }
}
