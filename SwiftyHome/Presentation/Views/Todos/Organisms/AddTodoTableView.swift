//
//  AddTodoTableView.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxDataSources
import RxSwift
import UIKit

class AddTodoTableView: UITableView {
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
        cell.addTodoView.descriptionTextView.rx.didChange.asObservable()
            .subscribe(onNext: {
                // The cursor overlaps and disappears the lowermost area during animations of expanding text area
                // The same solution like with Twitter, LINE, and so on
                UIView.performWithoutAnimation {
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
            })
            .disposed(by: cell.rx.reuseBag)
        return cell
    }
}
