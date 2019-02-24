//
//  SectionOfAddTodo.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxDataSources

enum AddTodoType {
    case core
}

struct SectionOfAddTodo {
    var items: [AddTodoType]
}

extension SectionOfAddTodo: SectionModelType {
    typealias Item = AddTodoType

    init(original: SectionOfAddTodo, items: [SectionOfAddTodo.Item]) {
        self = original
        self.items = items
    }
}
