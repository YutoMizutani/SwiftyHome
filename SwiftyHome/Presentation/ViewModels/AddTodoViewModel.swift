//
//  AddTodoViewModel.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/25.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift

class AddTodoViewModel: DeinitDisposable, ViewModel {
    typealias UseCaseType = TodosUseCase

    private let useCase: UseCaseType

    init(useCase: UseCaseType) {
        self.useCase = useCase
    }

    struct Input {
        let createTrigger: Driver<PostTodoEntity>
    }

    struct Output {
        let didCreateTodo: Driver<TodoEntity>
    }

    func transform(_ input: Input) -> Output {
        let didCreateTodo: Driver<TodoEntity> = input.createTrigger.asObservable()
            .flatMap { [unowned self] in self.useCase.create($0) }
            .asDriverOnErrorJustComplete()

        return Output(didCreateTodo: didCreateTodo)
    }
}
