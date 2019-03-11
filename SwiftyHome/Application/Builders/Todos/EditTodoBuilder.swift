//
//  EditTodoBuilder.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/03/09.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

struct EditTodoBuilder {
    func build(_ entity: TodoEntity) -> UIViewController {
        guard let viewController = EditTodoViewController.storyboard else {
            fatalError("Could not create instance of EditTodoViewController")
        }

        viewController.inject(
            viewModel: EditTodoViewModel(
                entity: entity,
                useCase: TodosUseCaseImpl(
                    repository: TodosRepositoryImpl.shared
                )
            )
        )

        return viewController
    }
}
