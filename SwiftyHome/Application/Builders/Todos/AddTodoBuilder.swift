//
//  AddTodoBuilder.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

struct AddTodoBuilder {
    func build() -> UIViewController {
        guard let viewController = AddTodoViewController.storyboard else {
            fatalError("Could not create instance of AddTodoViewController")
        }

        viewController.inject(
            viewModel: AddTodoViewModel(
                useCase: TodosUseCaseImpl(
                    repository: TodosRepositoryImpl.shared
                )
            )
        )

        return viewController
    }
}
