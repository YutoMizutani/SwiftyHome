//
//  TodosWireframe.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxSwift
import UIKit

protocol TodosWireframe {
    func toAddTodo() -> Single<Void>
}

class TodosWireframeImpl: TodosWireframe {
    weak var viewController: UIViewController?

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    func toAddTodo() -> Single<Void> {
        let nextViewController = AddTodoBuilder().buildWithNavigation()
        viewController?.present(nextViewController, animated: true)
        return Single.just(())
    }
}
