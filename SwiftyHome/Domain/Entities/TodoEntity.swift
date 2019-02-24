//
//  TodoEntity.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Foundation

struct PostTodoEntity {
    var title: String
    var description: String
    var tags: [String]
    var state: TodoState
}

struct TodoEntity {
    var id: PrimitiveID
    var title: String
    var description: String
    var tags: [String]
    var state: TodoState
}
