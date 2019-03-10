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
        let doneTodoTrigger: Driver<Int>
        let deleteTodoTrigger: Driver<Int>
        let toAddTodoTrigger: Driver<Void>
        let toEditTodoTrigger: Driver<Int>
    }
    struct Output {
        let menus: Driver<[SectionOfTodos]>
    }

    func transform(_ input: TodosViewModel.Input) -> TodosViewModel.Output {
        let menuRelay: PublishRelay<[TodoEntity]> = PublishRelay()
        let menus = menuRelay
            .map { [SectionOfTodos(items: $0)] }
            .asDriverOnErrorJustComplete()

        input.getContentsTrigger.asObservable()
            .flatMap { [unowned self] in self.useCase.fetchAll() }
            .subscribe(onNext: {
                menuRelay.accept($0.sorted())
            })
            .disposed(by: compositeDisposable)

        let doneEntity: Observable<TodoEntity> = input.doneTodoTrigger.asObservable()
            .withLatestFrom(menuRelay) { $1[$0] }
            .map { entity -> TodoEntity in
                var result = entity
                result.state = TodoState(!result.state.isDone)
                return result
            }
            .share(replay: 1)
        let expectDoneEntity: Observable<TodoEntity> = doneEntity
        let fetchResultDoneEntity: Observable<TodoEntity> = doneEntity
            .flatMap { [unowned self] in self.useCase.done($0) }
        Observable.merge(expectDoneEntity, fetchResultDoneEntity)
            .withLatestFrom(menuRelay) { ($0, $1) }
            .subscribe(onNext: { entity, menus in
                menuRelay.accept(
                    (menus.filter { $0.id.value != entity.id.value } + [entity]).sorted()
                )
            })
            .disposed(by: compositeDisposable)

        input.deleteTodoTrigger.asObservable()
            .withLatestFrom(menuRelay) { $1[$0] }
            .flatMap { [unowned self] in self.useCase.delete($0) }
            .subscribeAndDisposed(by: compositeDisposable)

        input.toAddTodoTrigger.asObservable()
            .subscribeOn(MainScheduler.asyncInstance)
            .flatMap { [unowned self] in self.wireframe.toAddTodo() }
            .subscribeAndDisposed(by: compositeDisposable)

        input.toEditTodoTrigger.asObservable()
            .withLatestFrom(menuRelay) { $1[$0] }
            .subscribeOn(MainScheduler.asyncInstance)
            .flatMap { [unowned self] in self.wireframe.toEditTodo($0) }
            .subscribeAndDisposed(by: compositeDisposable)

        return Output(menus: menus)
    }
}
