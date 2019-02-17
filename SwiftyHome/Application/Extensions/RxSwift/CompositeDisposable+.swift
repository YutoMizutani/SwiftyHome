//
//  CompositeDisposable+.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/17.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift

extension CompositeDisposable {
    @discardableResult
    func add(_ disposable: Disposable) -> DisposeKey? {
        return insert(disposable)
    }
}

extension Disposable {
    @discardableResult
    func disposed(by disposable: CompositeDisposable) -> CompositeDisposable.DisposeKey? {
        return disposable.insert(self)
    }
}

extension ObservableType {
    @discardableResult
    func subscribeAndDisposed(by disposable: CompositeDisposable) -> CompositeDisposable.DisposeKey? {
        return disposable.insert(self.subscribe())
    }
}
