//
//  MenuEntity.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Foundation

struct MenuEntity {
    var title: String
    var description: String
    var routes: [Route]

    struct Route {
        var title: String
        var path: String
    }
}
