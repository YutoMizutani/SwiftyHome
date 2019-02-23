//
//  CollectionMenuTableView.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/23.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxDataSources
import RxSwift
import UIKit

class CollectionMenuTableView: UITableView {
    var disposeBag = DisposeBag()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        configureView()
        binding()
        layoutView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configureView()
        binding()
        layoutView()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutView()
        layoutIfNeeded()
    }

    private func configureView() {
        rowHeight = 100
        estimatedRowHeight = 100
        separatorInset = UIEdgeInsets(top: 0, left: 100, bottom: 0, right: 0)
        register(CollectionMenuTableViewCell.nib, forCellReuseIdentifier: CollectionMenuTableViewCell.reuseIdentifier)
    }

    private func layoutView() {
    }

    private func binding() {
    }

    lazy var configureDataSource = RxTableViewSectionedReloadDataSource<SectionOfCollectionMenu>(configureCell: configureCell)

    lazy var configureCell: RxTableViewSectionedReloadDataSource<SectionOfCollectionMenu>.ConfigureCell = { [weak self] _, tableView, indexPath, item in
        guard let self = self else { return UITableViewCell() }
        let cell: CollectionMenuTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.thumbnailImageView.image = item.image
        cell.descriptionView.titleLabel.text = item.title
        cell.descriptionView.descriptionLabel.text = item.description
        cell.descriptionView.optionLabel.text = "0 routes"
        return cell
    }
}
