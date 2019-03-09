//
//  CollectionMenuTableViewCell.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/23.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

class CollectionMenuTableViewCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var thumbnailImageView: CollectionMenuContentImageView!
    @IBOutlet weak var descriptionView: CollectionMenuContentView!

    override func prepareForReuse() {
        super.prepareForReuse()
        reuseView()
    }

    private func reuseView() {
        thumbnailImageView.reuseView()
        descriptionView.reuseView()
    }
}
