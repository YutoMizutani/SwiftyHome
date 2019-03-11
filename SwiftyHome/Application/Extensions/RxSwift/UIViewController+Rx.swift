//
//  UIViewController+Rx.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/18.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

protocol HasDisposable {
    var disposeBag: DisposeBag { get set }
}
protocol HasCompositeDisposable {
    var compositeDisposable: CompositeDisposable { get set }
}

extension Reactive where Base: UIViewController {
    var viewDidLoad: Observable<[Any]> {
        return self.sentMessage(#selector(self.base.viewDidLoad)).share(replay: 1)
    }

    var viewDidLoadAndNow: Observable<Void> {
        return viewDidLoad.mapToVoid().startWith(()).share(replay: 1)
    }

    var viewWillAppear: Observable<[Any]> {
        return self.sentMessage(#selector(self.base.viewWillAppear)).share(replay: 1)
    }

    var viewDidAppear: Observable<[Any]> {
        return self.sentMessage(#selector(self.base.viewDidAppear)).share(replay: 1)
    }

    var viewDidDisappear: Observable<[Any]> {
        return self.sentMessage(#selector(self.base.viewDidDisappear)).share(replay: 1)
    }
}
