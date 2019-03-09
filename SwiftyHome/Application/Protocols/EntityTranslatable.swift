//
//  EntityTranslatable.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/17.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Foundation

protocol EntityTranslatable {
    associatedtype EntityType

    func toEntity() -> EntityType
}
