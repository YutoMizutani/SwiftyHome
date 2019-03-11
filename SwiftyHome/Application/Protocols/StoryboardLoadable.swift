//
//  StoryboardLoadable.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/18.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

/// Storyboard の読み込みが可能な protocol
public protocol StoryboardLoadable {
    associatedtype T = Self where T: UIViewController

    /// クラス名と一致した Storyboard ファイルを読み出す
    static var storyboard: T? { get }
}

public extension StoryboardLoadable where Self: UIViewController {
    /// クラス名と一致した Storyboard ファイルを読み出す
    static var storyboard: T? {
        return UIStoryboard(name: className, bundle: nil).instantiateViewController(withIdentifier: className) as? T
    }
}
