//
//  SectionOfTodos.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxDataSources

struct SectionOfTodos {
    var items: [TodoEntity]
}

extension SectionOfTodos: SectionModelType {
    typealias Item = TodoEntity

    init(original: SectionOfTodos, items: [SectionOfTodos.Item]) {
        self = original
        self.items = items
    }
}
