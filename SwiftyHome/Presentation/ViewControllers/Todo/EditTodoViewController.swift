//
//  EditTodoViewController.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/03/09.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class EditTodoViewController: UIViewController, StoryboardLoadable {
    typealias ViewModelType = EditTodoViewModel

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
        title = "Edit"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
    }

    private func binding() {
        navigationItem.leftBarButtonItem?.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)

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

        let editTrigger: Driver<PostTodoEntity> = rightBarButtonItem.rx.tap.asObservable()
            .withLatestFrom(tableView.rx.title)
            .withLatestFrom(tableView.rx.description) { (title: $0, description: $1) }
            .map { PostTodoEntity(title: $0.title, description: $0.description, tags: [], state: .disabled) }
            .asDriverOnErrorJustComplete()

        let output = viewModel.transform(EditTodoViewModel.Input(editTrigger: editTrigger))

        output.entity
            .map { $0.title }
            .drive(onNext: { [weak self] in
                self?.tableView.titleText = $0
            })
            .disposed(by: disposeBag)
        output.entity
            .map { $0.description }
            .drive(onNext: { [weak self] in
                self?.tableView.descriptionText = $0
            })
            .disposed(by: disposeBag)

        output.didUpdate.asObservable()
            .subscribeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            })
            .disposed(by: disposeBag)
    }
}
