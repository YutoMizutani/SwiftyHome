//
//  DoneTodoAPI.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Alamofire
import RxSwift

class DoneTodoAPI: GoHomeAPI {
    typealias ResponseType = EmptyResponse

    var path: String {
        return "/todos/\(id.value)"
    }
    var id: PrimitiveID!
    var method: HTTPMethod {
        return isDone ? .delete : .put
    }
    var isDone: Bool!

    func request(_ id: PrimitiveID, isDone: Bool) -> Single<ResponseType.EntityType> {
        self.id = id
        self.isDone = isDone
        return _request().map { $0.toEntity() }
    }
}
