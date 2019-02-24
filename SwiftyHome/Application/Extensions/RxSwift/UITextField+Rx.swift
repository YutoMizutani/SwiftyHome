//
//  UITextField+Rx.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/25.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

public extension Reactive where Base: UITextField {

    /// Reactive wrapper for `delegate`.
    ///
    /// For more information take a look at `DelegateProxyType` protocol documentation.
    var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
        return RxTextFieldDelegateProxy.proxy(for: base)
    }

    /// Reactive wrapper for `delegate` message.
    var shouldReturn: ControlEvent<UITextField> {
        let source = delegate.rx.methodInvoked(#selector(UITextFieldDelegate.textFieldShouldReturn))
            .map { $0[0] as! UITextField }

        return ControlEvent(events: source)
    }

    var shouldClear: ControlEvent<Void> {
        let source = delegate.rx.methodInvoked(#selector(UITextFieldDelegate.textFieldShouldClear))
            .map { _ in }

        return ControlEvent(events: source)
    }

}
