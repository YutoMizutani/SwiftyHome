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

    /// Delete todo trigger
    private let deleteTrigger: PublishRelay<IndexPath> = PublishRelay()

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

        // Enable to edit cells
        tableView.configureDataSource.canEditRowAtIndexPath = { _, _ in
            return true
        }
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }

    private func configureViewModel() {
        guard let viewModel = viewModel else { return }

        let getContentsTrigger: Driver<Void> = rx.viewDidAppear.mapToVoid().asDriverOnErrorJustComplete()
        let doneTodoTrigger: Driver<Int> = tableView.rx.itemSelected.map { $0.row }.asDriverOnErrorJustComplete()
        let deleteTodoTrigger: Driver<Int> = deleteTrigger.map { $0.row }.asDriverOnErrorJustComplete()
        let toAddTodoTrigger: Driver<Void> = navigationItem.rightBarButtonItem?.rx.tap.asObservable().asDriverOnErrorJustComplete() ?? .empty()
        let toEditTodoTrigger: Driver<Int> = tableView.rx.itemAccessoryButtonTapped.map { $0.row }.asDriverOnErrorJustComplete()

        let output = viewModel.transform(ViewModelType.Input(getContentsTrigger: getContentsTrigger,
                                                             doneTodoTrigger: doneTodoTrigger,
                                                             deleteTodoTrigger: deleteTodoTrigger,
                                                             toAddTodoTrigger: toAddTodoTrigger,
                                                             toEditTodoTrigger: toEditTodoTrigger))

        output.menus
            .drive(tableView.rx.items(dataSource: tableView.configureDataSource))
            .disposed(by: disposeBag)
    }
}

extension TodosViewController: UITableViewDelegate {
    /// Set swipe actions
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let destructiveAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completion in
            // Notice to ViewModel
            self?.deleteTrigger.accept(indexPath)
            // Delete cell animation (data source is not changed)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [destructiveAction])
    }
}
