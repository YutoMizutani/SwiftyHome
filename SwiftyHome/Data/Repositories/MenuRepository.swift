//
//  MenuRepository.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/17.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxSwift

protocol MenuRepository {
    func fetch() -> Single<[MenuEntity]>
}

class MenuRepositoryImpl: MenuRepository {
    private let api: MenuAPI = MenuAPI()

    private init() {}

    static let shared: MenuRepositoryImpl = MenuRepositoryImpl()

    func fetch() -> Single<[MenuEntity]> {
        return api.request()
    }
}
