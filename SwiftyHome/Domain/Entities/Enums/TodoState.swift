//
//  TodoState.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

enum TodoState {
    case enabled, disabled

    init(_ bool: Bool) {
        if bool {
            self = .enabled
        } else {
            self = .disabled
        }
    }
}

extension TodoState {
    var image: UIImage {
        switch self {
        case .enabled:
            return UIImage(named: "todo_enabled")!
        case .disabled:
            return UIImage(named: "todo_disabled")!
        }
    }
}
