//
//  TodosUseCase.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxSwift

protocol TodosUseCase {
    func fetchAll() -> Single<[TodoEntity]>
    func fetch(_ id: PrimitiveID) -> Single<TodoEntity>
    func create(_ postEntity: PostTodoEntity) -> Single<TodoEntity>
    func update(_ entity: TodoEntity) -> Single<TodoEntity>
    func done(_ entity: TodoEntity) -> Single<Void>
    func delete(_ entity: TodoEntity) -> Single<Void>
}

class TodosUseCaseImpl: TodosUseCase {
    typealias RepositoryType = TodosRepository

    private let repository: RepositoryType

    init(repository: RepositoryType) {
        self.repository = repository
    }

    func fetchAll() -> Single<[TodoEntity]> {
        return repository.fetchAll()
    }

    func fetch(_ id: PrimitiveID) -> Single<TodoEntity> {
        return repository.fetch(id)
    }

    func create(_ postEntity: PostTodoEntity) -> Single<TodoEntity> {
        return repository.create(postEntity)
    }

    func update(_ entity: TodoEntity) -> Single<TodoEntity> {
        return repository.update(entity)
    }

    func done(_ entity: TodoEntity) -> Single<Void> {
        return repository.done(entity)
    }

    func delete(_ entity: TodoEntity) -> Single<Void> {
        return repository.delete(entity)
    }
}
