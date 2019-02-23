//
//  CollectionMenuContentImageView.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

@IBDesignable
class CollectionMenuContentImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    private func configureView() {
        contentMode = .scaleAspectFill
    }

    func reuseView() {
        image = nil
    }
}
