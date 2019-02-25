//
//  AddTodoTableView.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxGesture
import RxSwift
import UIKit

class AddTodoTableView: UITableView {
    fileprivate let titleSubject: PublishSubject<String> = PublishSubject()
    fileprivate let descriptionSubject: PublishSubject<String> = PublishSubject()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureView()
    }

    private func configureView() {
        separatorColor = .clear
        estimatedRowHeight = 1000
        register(AddTodoTableViewCell.nib, forCellReuseIdentifier: AddTodoTableViewCell.reuseIdentifier)
    }

    lazy var configureDataSource = RxTableViewSectionedReloadDataSource<SectionOfAddTodo>(configureCell: configureCell)

    lazy var configureCell: RxTableViewSectionedReloadDataSource<SectionOfAddTodo>.ConfigureCell = { [weak self] _, tableView, indexPath, item in
        guard let self = self else { return UITableViewCell() }
        let cell: AddTodoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.selectionStyle = UITableViewCell.SelectionStyle.none

        // Display keyboard
        tableView.rx.willDisplayCell.asObservable().mapToVoid()
            .subscribe(onNext: {
                cell.addTodoView.titleTextField.becomeFirstResponder()
            })
            .disposed(by: cell.rx.reuseBag)

        // Next keyboard
        let nextButtonOfKeyboardsTappedOnTitleTextField = cell.addTodoView.titleTextField.rx.shouldReturn.asObservable()
            .filter { $0.returnKeyType == .next }
            .filter { $0 == cell.addTodoView.titleTextField }.mapToVoid()
        let theOtherTableViewLocationTapped = tableView.rx.tapGesture().when(.recognized).asObservable()
            .filter { !cell.addTodoView.titleTextField.frame.contains($0.location(in: tableView)) }
            .mapToVoid()
        Observable.merge(nextButtonOfKeyboardsTappedOnTitleTextField, theOtherTableViewLocationTapped)
            .subscribe(onNext: {
                // Show keyboard of descriptionTextView when next return key or the other location tapped
                cell.addTodoView.descriptionTextView.becomeFirstResponder()
            })
            .disposed(by: cell.rx.reuseBag)

        // Expand textview area
        let didChangeDescription = cell.addTodoView.descriptionTextView.rx.didChange.asObservable()
            .share(replay: 1)
        didChangeDescription
            .subscribe(onNext: {
                // The cursor overlaps and disappears the lowermost area during animations of expanding text area
                // The same solution like with Twitter, LINE, and so on
                UIView.performWithoutAnimation {
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            })
            .disposed(by: cell.rx.reuseBag)

        cell.addTodoView.titleTextField.rx.controlEvent(.editingChanged).startWith(())
            .asObservable()
            .map { cell.addTodoView.titleTextField.text ?? "" }
            .subscribe(onNext: { [weak self] in
                self?.titleSubject.onNext($0)
            })
            .disposed(by: cell.rx.reuseBag)

        didChangeDescription
            .map { cell.addTodoView.descriptionTextView.text ?? "" }
            .subscribe(onNext: { [weak self] in
                self?.descriptionSubject.onNext($0)
            })
            .disposed(by: cell.rx.reuseBag)

        return cell
    }
}

extension Reactive where Base: AddTodoTableView {
    var title: Observable<String> {
        return base.titleSubject.asObservable().share(replay: 1)
    }

    /// KVO of todo title is empty
    var titleIsEmpty: Observable<Bool> {
        return base.titleSubject.map { $0.isEmpty }.asObservable().share(replay: 1)
    }

    var description: Observable<String> {
        return base.descriptionSubject.asObservable().share(replay: 1)
    }
}
