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
    @IBOutlet weak var tableView: AddTodoTableView!

    private var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        binding()
    }

    private func configureView() {
        title = CollectionMenuType.todos.title
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: nil)
    }

    private func binding() {
        navigationItem.leftBarButtonItem?.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        navigationItem.rightBarButtonItem?.rx.tap.asObservable()
            .subscribe(onNext: {
                print("Done!")
            })
            .disposed(by: disposeBag)

        rx.viewDidLoadAndNow
            .map { [SectionOfAddTodo(items: [AddTodoType.core])] }
            .observeOn(MainScheduler.asyncInstance)
            .bind(to: tableView.rx.items(dataSource: tableView.configureDataSource))
            .disposed(by: disposeBag)
    }
}
