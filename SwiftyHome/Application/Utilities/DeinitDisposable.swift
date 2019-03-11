//
//  DeinitDisposable.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxSwift

class DeinitDisposable {
    final let compositeDisposable = CompositeDisposable()

    deinit {
        compositeDisposable.dispose()
    }
}
