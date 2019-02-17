//
//  MenuResponse.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/17.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Foundation

struct MenuResponse: Codable, EntityTranslatable {
    let title: String
    let description: String
    let routes: [Route]

    struct Route: Codable, EntityTranslatable {
        let title: String
        let path: String

        typealias EntityType = MenuEntity.Route
        func toEntity() -> MenuResponse.Route.EntityType {
            return MenuEntity.Route(title: title,
                                    path: path)
        }
    }

    typealias EntityType = MenuEntity
    func toEntity() -> MenuResponse.EntityType {
        return MenuEntity(title: title,
                          description: description,
                          routes: routes.map { $0.toEntity() })
    }
}
