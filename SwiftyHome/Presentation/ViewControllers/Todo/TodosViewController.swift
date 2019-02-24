//
//  TodosViewController.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class TodosViewController: UIViewController, StoryboardLoadable, SwipeDismissable {
    typealias ViewModelType = TodosViewModel

    @IBOutlet weak var tableView: TodoTableView!

    private var viewModel: ViewModelType?
    private var disposeBag = DisposeBag()

    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureSwipeDismissing()
        configureView()
        configureViewModel()
    }

    private func configureView() {
        title = CollectionMenuType.todos.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "todo_add")!,
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
    }

    private func configureViewModel() {
        guard let viewModel = viewModel else { return }

        let getContentsTrigger: Driver<Void> = rx.viewDidAppear.mapToVoid().asDriverOnErrorJustComplete()
        let toAddTodoTrigger: Driver<Void> = navigationItem.rightBarButtonItem?.rx.tap.asObservable().asDriverOnErrorJustComplete() ?? .empty()

        let output = viewModel.transform(ViewModelType.Input(getContentsTrigger: getContentsTrigger, toAddTodoTrigger: toAddTodoTrigger))

        output.menus
            .drive(tableView.rx.items(dataSource: tableView.configureDataSource))
            .disposed(by: disposeBag)
    }
}
