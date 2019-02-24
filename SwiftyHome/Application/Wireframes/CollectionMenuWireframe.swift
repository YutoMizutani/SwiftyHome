//
//  CollectionMenuWireframe.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxSwift
import UIKit

protocol CollectionMenuWireframe {
    func toTodos() -> Single<Void>
}

class CollectionMenuWireframeImpl: CollectionMenuWireframe {
    weak var navigationController: UINavigationController?

    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func toTodos() -> Single<Void> {
        let nextViewController = TodosBuilder().build()
        navigationController?.pushViewController(nextViewController, animated: true)
        return Single.just(())
    }
}
