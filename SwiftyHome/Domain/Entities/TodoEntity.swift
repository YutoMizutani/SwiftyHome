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

    func toParameters() -> [String: Any] {
        var parameters: [String: Any] = [:]
        parameters["title"] = title
        parameters["description"] = description
        parameters["tags"] = tags
        parameters["is_done"] = state.isDone
        return parameters
    }
}

struct TodoEntity {
    var id: PrimitiveID
    var title: String
    var description: String
    var tags: [String]
    var state: TodoState
}

extension Array where Element == TodoEntity {
    func sorted() -> [Element] {
        return sorted { $0.id.value > $1.id.value }
    }
}
