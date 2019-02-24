//
//  TodosBuilder.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

struct TodosBuilder {
    func build() -> TodosViewController {
        guard let viewController = TodosViewController.storyboard else {
            fatalError("Could not create instance of TodosViewController")
        }
        viewController.inject(
            viewModel: TodosViewModel(
                useCase: TodosUseCaseImpl(
                    repository: TodosRepositoryImpl.shared
                ),
                wireframe: TodosWireframeImpl(viewController)
            )
        )

        return viewController
    }
}
