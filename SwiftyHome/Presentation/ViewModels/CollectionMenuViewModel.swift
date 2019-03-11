//
//  CollectionMenuViewModel.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift

class CollectionMenuViewModel: DeinitDisposable, ViewModel {
    typealias UseCaseType = MenuUseCase
    typealias WireframeType = CollectionMenuWireframe

    private let useCase: UseCaseType
    private let wireframe: WireframeType

    private let items: [SectionOfCollectionMenu] = CollectionMenuType.allCases.map { [$0] }
        .map { SectionOfCollectionMenu(items: $0) }

    init(useCase: UseCaseType, wireframe: WireframeType) {
        self.useCase = useCase
        self.wireframe = wireframe
    }

    struct Input {
        let getContentsTrigger: Driver<Void>
        let toTodosTrigger: Driver<Void>
    }
    struct Output {}

    var menus: PublishSubject<[SectionOfCollectionMenu]> = PublishSubject()

    func transform(_ input: CollectionMenuViewModel.Input) -> CollectionMenuViewModel.Output {
        input.getContentsTrigger.asObservable()
            .map { [weak self] in self?.items ?? [] }
            .bind(to: menus)
            .disposed(by: compositeDisposable)

        input.toTodosTrigger.asObservable()
            .flatMap { [unowned self] in self.wireframe.toTodos() }
            .subscribeAndDisposed(by: compositeDisposable)

        return Output()
    }
}
