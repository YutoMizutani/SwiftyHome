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
        let panGestureRecognizer = HorizontalRightToLeftPanGestureRecognizer(target: target, action: Selector(("handleNavigationTransition:")))
        view.addGestureRecognizer(panGestureRecognizer)
    }
}

private class HorizontalRightToLeftPanGestureRecognizer: UIPanGestureRecognizer, UIGestureRecognizerDelegate {
    override init(target: Any?, action: Selector?) {
        super.init(target: target, action: action)
        delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let panGestureRecognizer = gestureRecognizer as! UIPanGestureRecognizer
        let translation = panGestureRecognizer.translation(in: panGestureRecognizer.view)
        let isHorizontalSwipe = abs(translation.x) > abs(translation.y)
        let isRightToLeftSwipe = translation.x > 0
        return isHorizontalSwipe && isRightToLeftSwipe
    }
}
