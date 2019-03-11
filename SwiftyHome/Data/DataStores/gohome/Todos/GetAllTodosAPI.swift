//
//  GetAllTodosAPI.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Alamofire
import RxSwift

struct GetAllTodosAPI: GoHomeAPI {
    typealias ResponseType = [TodoResponse]

    let path: String = "/todos"
    let method: HTTPMethod = .get

    func request() -> Single<[ResponseType.Element.EntityType]> {
        return _request().map { $0.map { $0.toEntity() } }
    }
}
