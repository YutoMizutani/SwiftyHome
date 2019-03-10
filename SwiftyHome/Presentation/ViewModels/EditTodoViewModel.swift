//
//  EditTodoViewModel.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/03/09.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift

class EditTodoViewModel: DeinitDisposable, ViewModel {
    typealias UseCaseType = TodosUseCase

    private var entity: TodoEntity
    private let useCase: UseCaseType

    init(entity: TodoEntity, useCase: UseCaseType) {
        self.entity = entity
        self.useCase = useCase
    }

    struct Input {
        let editTrigger: Driver<PostTodoEntity>
    }

    struct Output {
        let entity: Driver<TodoEntity>
        let didUpdate: Driver<TodoEntity>
    }

    func transform(_ input: Input) -> Output {
        let entity: Driver<TodoEntity> = Driver.just(self.entity)

        let didUpdate: Driver<TodoEntity> = input.editTrigger.asObservable()
            .withLatestFrom(entity) { ($0, $1) }
            .map {
                var entity = $0.1
                entity.title = $0.0.title
                entity.description = $0.0.description
                entity.tags = $0.0.tags
                entity.state = $0.0.state
                return entity
            }
            .debug()
            .flatMapLatest { [unowned self] in self.useCase.update($0) }
            .debug()
            .asDriverOnErrorJustComplete()

        return Output(entity: entity,
                      didUpdate: didUpdate)
    }
}
