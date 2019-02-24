//
//  SwipeDismissable.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

protocol SwipeDismissable {
    /// 画面端でない場所からのスワイプで前のViewへ戻る機能の設定
    func configureSwipeDismissing()
}

extension SwipeDismissable where Self: UIViewController {
    func configureSwipeDismissing() {
        let target = navigationController?.value(forKey: "_cachedInteractionController")
        let panGestureRecognizercognizer = UIPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        view.addGestureRecognizer(panGestureRecognizercognizer)
    }
}
