//
//  TodoTableView.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxDataSources
import RxSwift
import UIKit

class TodoTableView: UITableView {
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
        rowHeight = 44
        estimatedRowHeight = 44
        register(TodoTableViewCell.nib, forCellReuseIdentifier: TodoTableViewCell.reuseIdentifier)
    }

    lazy var configureDataSource = RxTableViewSectionedReloadDataSource<SectionOfTodos>(configureCell: configureCell)

    lazy var configureCell: RxTableViewSectionedReloadDataSource<SectionOfTodos>.ConfigureCell = { [weak self] _, tableView, indexPath, item in
        guard let self = self else { return UITableViewCell() }
        let cell: TodoTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.state = item.state
        cell.todoView.titleLabel.text = item.title
        return cell
    }
}
