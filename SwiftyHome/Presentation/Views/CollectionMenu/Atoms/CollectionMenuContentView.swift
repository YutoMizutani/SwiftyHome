//
//  CollectionMenuContentView.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

class CollectionMenuContentView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        reuseView()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        reuseView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        reuseView()
    }

    func reuseView() {
        titleLabel.text = nil
        descriptionLabel.text = nil
        optionLabel.text = nil
    }
}
