//
//  RxTextFieldDelegateProxy.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/25.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

#if os(iOS) || os(tvOS)

import RxCocoa
import RxSwift
import UIKit

extension UITextField: HasDelegate {
    public typealias Delegate = UITextFieldDelegate
}

/// For more information take a look at `DelegateProxyType`.
open class RxTextFieldDelegateProxy
    : DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {

    public static func currentDelegate(for object: UITextField) -> UITextFieldDelegate? {
        return object.delegate
    }

    public static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: UITextField) {
        object.delegate = delegate
    }

    /// Typed parent object.
    public weak private(set) var textField: UITextField?

    /// - parameter textfield: Parent object for delegate proxy.
    public init(textField: ParentObject) {
        self.textField = textField
        super.init(parentObject: textField, delegateProxy: RxTextFieldDelegateProxy.self)
    }

    // Register known implementations
    public static func registerKnownImplementations() {
        register(make: RxTextFieldDelegateProxy.init)
    }

    // MARK: delegate methods
    /// For more information take a look at `DelegateProxyType`.
    @objc open func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return forwardToDelegate()?.textFieldShouldReturn?(textField) ?? true
    }

    @objc open func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return forwardToDelegate()?.textFieldShouldClear?(textField) ?? true
    }
}

#endif
