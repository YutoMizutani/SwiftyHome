//
//  TodosRepository.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxSwift

protocol TodosRepository {
    func fetchAll() -> Single<[TodoEntity]>
    func fetch(_ id: PrimitiveID) -> Single<TodoEntity>
    func create(_ postEntity: PostTodoEntity) -> Single<TodoEntity>
    func update(_ entity: TodoEntity) -> Single<TodoEntity>
    func done(_ entity: TodoEntity) -> Single<Void>
    func delete(_ entity: TodoEntity) -> Single<Void>
}

class TodosRepositoryImpl: TodosRepository {
    private let getAllAPI = GetAllTodosAPI()
    private let getAPI = GetTodoAPI()
    private let createAPI = CreateTodoAPI()
    private let updateAPI = UpdateTodoAPI()
    private let doneAPI = DoneTodoAPI()
    private let deleteAPI = DeleteTodoAPI()

    private init() {}

    static let shared: TodosRepositoryImpl = TodosRepositoryImpl()

    func fetchAll() -> Single<[TodoEntity]> {
        return getAllAPI.request()
    }

    func fetch(_ id: PrimitiveID) -> Single<TodoEntity> {
        return getAPI.request(id)
    }

    func create(_ postEntity: PostTodoEntity) -> Single<TodoEntity> {
        return createAPI.request(postEntity)
    }

    func update(_ entity: TodoEntity) -> Single<TodoEntity> {
        return updateAPI.request(entity)
    }

    func done(_ entity: TodoEntity) -> Single<Void> {
        return doneAPI.request(entity.id, isDone: entity.state == .enabled)
    }

    func delete(_ entity: TodoEntity) -> Single<Void> {
        return deleteAPI.request(entity.id)
    }
}
