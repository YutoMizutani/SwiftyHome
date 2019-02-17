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
    var defaultCornerRadius: CGFloat = 10

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
        backgroundColor = .lightGray
        contentMode = .scaleAspectFill
        cornerRadius = cornerRadius == 0 ? defaultCornerRadius : cornerRadius
    }

    func reuseView() {
        image = nil
    }
}
