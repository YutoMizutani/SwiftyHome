//
//  SectionOfEditTodo.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxDataSources

enum EditTodoType {
    case core
}

struct SectionOfEditTodo {
    var items: [EditTodoType]
}

extension SectionOfEditTodo: SectionModelType {
    typealias Item = EditTodoType

    init(original: SectionOfEditTodo, items: [SectionOfEditTodo.Item]) {
        self = original
        self.items = items
    }
}
