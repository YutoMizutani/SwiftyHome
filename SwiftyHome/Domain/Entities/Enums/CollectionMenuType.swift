//
//  CollectionMenuType.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

enum CollectionMenuType: String, CaseIterable, Equatable {
    case todos, home, settings
}

extension CollectionMenuType {
    var title: String {
        return rawValue.capitalized
    }

    var description: String {
        switch self {
        case .todos:
            return "Todo lists"
        case .home:
            return "Daily lives contents"
        case .settings:
            return "Settings"
        }
    }

    var image: UIImage {
        return UIImage(named: "icon_\(rawValue)")!
    }
}
