//
//  CollectionMenuViewController.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class CollectionMenuViewController: UIViewController, StoryboardLoadable {
    typealias ViewModelType = CollectionMenuViewModel

    @IBOutlet weak var tableView: CollectionMenuTableView!

    private var viewModel: ViewModelType?
    private var disposeBag = DisposeBag()

    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }

    private func configureViewModel() {
        guard let viewModel = viewModel else { return }

        let getContentsTrigger: Driver<Void> = rx.viewDidAppear.mapToVoid().asDriverOnErrorJustComplete()

        _ = viewModel.transform(CollectionMenuViewModel.Input(getContentsTrigger: getContentsTrigger))

        viewModel.menus
            .bind(to: tableView.rx.items(dataSource: tableView.configureDataSource))
            .disposed(by: disposeBag)
    }
}
