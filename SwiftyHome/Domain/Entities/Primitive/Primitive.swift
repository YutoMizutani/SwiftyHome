//
//  Primitive.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import Foundation

class Primitive<T> {
    var value: T

    init(_ value: T) {
        self.value = value
    }
}
