//
//  MenuAPI.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/17.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Alamofire
import RxSwift

struct MenuAPI: GoHomeAPI {
    typealias ResponseType = [MenuResponse]

    var path: String = "/menu"
    var method: HTTPMethod = .get

    func request() -> Single<[MenuEntity]> {
        return _request().map { $0.map { $0.toEntity() } }
    }
}
