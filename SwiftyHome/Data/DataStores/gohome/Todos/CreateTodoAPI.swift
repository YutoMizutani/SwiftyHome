//
//  CreateTodoAPI.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Alamofire
import RxSwift

struct CreateTodoAPI: GoHomeAPI {
    typealias ResponseType = TodoResponse

    let path: String = "/todos"
    let method: HTTPMethod = .post

    func request(_ postEntity: PostTodoEntity) -> Single<ResponseType.EntityType> {
        let parameters: Parameters = postEntity.toParameters()
        return _request(parameters).map { $0.toEntity() }
    }
}
