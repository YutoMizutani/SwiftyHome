//
//  UpdateTodoAPI.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Alamofire
import RxSwift

class UpdateTodoAPI: GoHomeAPI {
    typealias ResponseType = TodoResponse

    var path: String {
        return "/todos/\(id.value)"
    }
    var id: PrimitiveID!
    let method: HTTPMethod = .put

    func request(_ entity: TodoEntity) -> Single<ResponseType.EntityType> {
        self.id = entity.id
        return _request(entity.toParameters())
            .map { $0.toEntity() }
    }
}
