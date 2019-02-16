//
//  SectionOfCollectionMenu.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxDataSources

enum CollectionMenuType {
    case content(MenuEntity)
}

struct SectionOfCollectionMenu {
    var items: [CollectionMenuType]
}

extension SectionOfCollectionMenu: SectionModelType {
    typealias Item = CollectionMenuType

    init(original: SectionOfCollectionMenu, items: [SectionOfCollectionMenu.Item]) {
        self = original
        self.items = items
    }
}
