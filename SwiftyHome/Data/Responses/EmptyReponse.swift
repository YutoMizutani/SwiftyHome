//
//  EmptyReponse.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Foundation

struct EmptyResponse: Codable, EntityTranslatable {
    typealias EntityType = Void

    func toEntity() {}
}
