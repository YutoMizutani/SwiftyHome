//
//  AddTodoViewController.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class AddTodoViewController: UIViewController, StoryboardLoadable {
    typealias ViewModelType = AddTodoViewModel

    @IBOutlet weak var tableView: EditTodoTableView!

    private var viewModel: ViewModelType?
    private var disposeBag = DisposeBag()

    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        binding()
        configureViewModel()
    }

    private func configureView() {
        title = "Add"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
    }

    private func binding() {
        rx.viewDidLoadAndNow
            .map { [SectionOfEditTodo(items: [EditTodoType.core])] }
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(dataSource: tableView.configureDataSource))
            .disposed(by: disposeBag)

        // Enable / disable right bar button item
        if let rightBarButtonItem = navigationItem.rightBarButtonItem {
            tableView.rx.titleIsEmpty.asObservable()
                .distinctUntilChanged()
                .map(!)
                .bind(to: rightBarButtonItem.rx.isEnabled)
                .disposed(by: disposeBag)
        }
    }

    private func configureViewModel() {
        guard let viewModel = viewModel, let rightBarButtonItem = navigationItem.rightBarButtonItem else { return }

        let createTrigger: Driver<PostTodoEntity> = rightBarButtonItem.rx.tap.asObservable()
            .withLatestFrom(tableView.rx.title.startWith(""))
            .withLatestFrom(tableView.rx.description.startWith("")) { (title: $0, description: $1) }
            .map { PostTodoEntity(title: $0.title, description: $0.description) }
            .asDriverOnErrorJustComplete()

        let output = viewModel.transform(AddTodoViewModel.Input(createTrigger: createTrigger))

        output.didCreateTodo.asObservable()
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
