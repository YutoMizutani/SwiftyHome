//
//  MenuBuilder.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/17.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

struct MenuBuilder {
    func build() -> CollectionMenuViewController {
        guard let viewController = CollectionMenuViewController.storyboard else {
            fatalError("Could not create instance of CollectionMenuViewController")
        }
        viewController.inject(
            viewModel: CollectionMenuViewModel(
                useCase: MenuUseCaseImpl(
                    repository: MenuRepositoryImpl.shared
                )
            )
        )
        return viewController
    }

    func buildWithNavigation() -> UINavigationController {
        let viewController = build()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.installBlurEffect()
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationItem.largeTitleDisplayMode = .always
        viewController.title = "Collections"
        return navigationController
    }
}
