//
//  CollectionMenuViewModel.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Foundation

class CollectionMenuViewModel: DeinitDisposable, ViewModel {
    struct Input {}
    struct Output {}

    func transform(_ input: CollectionMenuViewModel.Input) -> CollectionMenuViewModel.Output {
        return Output()
    }
}
