//
//  GetTodoAPI.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Alamofire
import RxSwift

class GetTodoAPI: GoHomeAPI {
    typealias ResponseType = TodoResponse

    var path: String {
        return "/todos/\(id.value)"
    }
    var id: PrimitiveID!
    let method: HTTPMethod = .get

    func request(_ id: PrimitiveID) -> Single<ResponseType.EntityType> {
        self.id = id
        return _request().map { $0.toEntity() }
    }
}
