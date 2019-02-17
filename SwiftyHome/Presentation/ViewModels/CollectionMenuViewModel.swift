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

    private let useCase: UseCaseType

    init(useCase: UseCaseType) {
        self.useCase = useCase
    }

    struct Input {
        let fetchTrigger: Driver<Void>
    }
    struct Output {}

    var menus: PublishSubject<[SectionOfCollectionMenu]> = PublishSubject()

    func transform(_ input: CollectionMenuViewModel.Input) -> CollectionMenuViewModel.Output {
        input.fetchTrigger.asObservable()
            .flatMapLatest { [unowned self] in self.useCase.fetch() }
            .map { $0.map { CollectionMenuType.content($0) } }
            .map { [SectionOfCollectionMenu(items: $0)] }
            .bind(to: menus)
            .disposed(by: compositeDisposable)

        return Output()
    }
}
