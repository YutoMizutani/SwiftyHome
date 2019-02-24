//
//  TodoResponse.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Foundation

struct TodoResponse: Codable, EntityTranslatable {
    var id: Int64
    var title: String
    var description: String
    var tags: [String]
    var isDone: Bool

    typealias EntityType = TodoEntity
    func toEntity() -> EntityType {
        return TodoEntity(id: PrimitiveID(id),
                          title: title,
                          description: description,
                          tags: tags,
                          state: TodoState(isDone))
    }
}
