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
    typealias ResponseType = TodoResponse

    var path: String {
        return "/todo/done/\(id.value)"
    }
    var id: PrimitiveID!
    let method: HTTPMethod = .put
    var isDone: Bool!

    func request(_ id: PrimitiveID, isDone: Bool) -> Single<ResponseType.EntityType> {
        self.id = id
        let parameters: Parameters = ["is_done": isDone]
        return _request(parameters).map { $0.toEntity() }
    }
}
