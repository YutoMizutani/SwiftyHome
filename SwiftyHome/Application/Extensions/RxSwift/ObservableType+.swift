//
//  ObservableType+.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/18.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift

extension ObservableType {
    func catchErrorJustComplete() -> Observable<E> {
        return catchError { _ in
            return Observable.empty()
        }
    }

    /// Map from any to void
    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }

    func mapToTrue() -> Observable<Bool> {
        return map { _ in true }
    }

    func mapToFalse() -> Observable<Bool> {
        return map { _ in false }
    }

    func toggle(startWith: Bool = false) -> Observable<Bool> {
        return scan(!startWith) { flag, _ in !flag }
    }

    func asDriverOnErrorJustComplete() -> Driver<E> {
        return asDriver { _ in
            return Driver.empty()
        }
    }

    /// Observable Current and Previous Value
    func withPrevious(startWith e: E? = nil) -> Observable<(previous: E, current: E)> {
        return scan((e, e)) { ($0.1, $1) }
            .filter({ $0.0 != nil && $0.1 != nil }).map { ($0.0!, $0.1!) }
    }

    func unwrap<T>() -> Observable<T> where E == T? {
        return filter { $0 != nil }.map { $0! }
    }
}
