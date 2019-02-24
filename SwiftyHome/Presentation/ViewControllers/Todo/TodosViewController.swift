//
//  TodosViewController.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

class TodosViewController: UIViewController {
//    typealias ViewModelType = MenuViewModel

    @IBOutlet weak var tableView: TodoTableView!

//    private var viewModel: ViewModelType?
//    private var disposeBag = DisposeBag()
//
//    func inject(viewModel: ViewModelType) {
//        self.viewModel = viewModel
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        configureViewModel()
//    }
//
//    private func configureViewModel() {
//        guard let viewModel = viewModel else { return }
//
//        let getContentsTrigger: Driver<Void> = rx.viewDidAppear.mapToVoid().asDriverOnErrorJustComplete()
//
//        _ = viewModel.transform(CollectionMenuViewModel.Input(getContentsTrigger: getContentsTrigger))
//
//        viewModel.menus
//            .bind(to: tableView.rx.items(dataSource: tableView.configureDataSource))
//            .disposed(by: disposeBag)
//    }
}
