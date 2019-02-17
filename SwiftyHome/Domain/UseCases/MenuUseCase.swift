//
//  MenuUseCase.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/17.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxSwift

protocol MenuUseCase {
    func fetch() -> Single<[MenuEntity]>
}

class MenuUseCaseImpl: MenuUseCase {
    typealias RepositoryType = MenuRepository

    private let repository: RepositoryType

    init(repository: RepositoryType) {
        self.repository = repository
    }

    func fetch() -> Single<[MenuEntity]> {
        return repository.fetch()
    }
}
