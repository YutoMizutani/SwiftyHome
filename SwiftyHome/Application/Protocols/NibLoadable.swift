//
//  NibLoadable.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

/// Nib の読み込みが可能な protocol
public protocol NibLoadable {
    /// クラス名と一致した Nib ファイルを読み出す
    static var nib: UINib { get }
}

public extension NibLoadable where Self: UIView {
    /// クラス名と一致した Nib ファイルを読み出す
    static var nib: UINib {
        return UINib(nibName: className, bundle: nil)
    }
}
