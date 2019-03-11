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
    func toEditTodo(_ entity: TodoEntity) -> Single<Void>
}

class TodosWireframeImpl: TodosWireframe {
    weak var viewController: UIViewController?

    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }

    func toAddTodo() -> Single<Void> {
        let nextViewController = AddTodoBuilder().build()
        viewController?.navigationController?.pushViewController(nextViewController, animated: true)
        return Single.just(())
    }

    func toEditTodo(_ entity: TodoEntity) -> Single<Void> {
        let nextViewController = EditTodoBuilder().build(entity)
        viewController?.navigationController?.pushViewController(nextViewController, animated: true)
        return Single.just(())
    }
}
