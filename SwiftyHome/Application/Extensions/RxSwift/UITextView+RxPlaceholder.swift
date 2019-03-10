//  UITextView+RxPlaceholder.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

extension UITextView {
    func configurePlaceholder(_ placeholder: String, color: UIColor = UIColor.officialApplePlaceholderGray) -> Disposable {
        let placeHolderLabel: UILabel = UILabel(frame: CGRect(x: 6.0, y: 6.0, width: 0.0, height: 0.0))
        placeHolderLabel.text = placeholder
        placeHolderLabel.sizeToFit()
        placeHolderLabel.lineBreakMode = .byWordWrapping
        placeHolderLabel.numberOfLines = 0
        placeHolderLabel.font = font
        placeHolderLabel.textColor = color
        placeHolderLabel.backgroundColor = .clear
        addSubview(placeHolderLabel)

        return rx.text.subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            if placeholder.isEmpty || !self.text.isEmpty {
                placeHolderLabel.alpha = 0.0
            } else {
                placeHolderLabel.alpha = 1.0
            }
        })
    }
}
