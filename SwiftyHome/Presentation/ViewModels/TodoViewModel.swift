//
//  TodoViewModel.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift

class TodosViewModel: DeinitDisposable, ViewModel {
    typealias UseCaseType = TodosUseCase
    typealias WireframeType = TodosWireframe

    private let useCase: UseCaseType
    private let wireframe: WireframeType

    init(useCase: UseCaseType, wireframe: WireframeType) {
        self.useCase = useCase
        self.wireframe = wireframe
    }

    struct Input {
        let getContentsTrigger: Driver<Void>
        let toAddTodoTrigger: Driver<Void>
    }
    struct Output {}

    var menus: PublishSubject<[SectionOfTodos]> = PublishSubject()

    func transform(_ input: TodosViewModel.Input) -> TodosViewModel.Output {
        input.getContentsTrigger.asObservable()
            .flatMap { [unowned self] in self.useCase.fetchAll() }
            .map { $0.map { SectionOfTodos(items: [$0]) } }
            .bind(to: menus)
            .disposed(by: compositeDisposable)

        input.toAddTodoTrigger.asObservable()
            .subscribeOn(MainScheduler.asyncInstance)
            .flatMap { [unowned self] in self.wireframe.toAddTodo() }
            .subscribeAndDisposed(by: compositeDisposable)

        return Output()
    }
}
