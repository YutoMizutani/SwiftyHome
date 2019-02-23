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
        rowHeight = 150
        estimatedRowHeight = 150
        register(CollectionMenuTableViewCell.nib, forCellReuseIdentifier: CollectionMenuTableViewCell.reuseIdentifier)
    }

    private func layoutView() {
    }

    private func binding() {
    }

    lazy var configureDataSource = RxTableViewSectionedReloadDataSource<SectionOfCollectionMenu>(configureCell: configureCell)

    lazy var configureCell: RxTableViewSectionedReloadDataSource<SectionOfCollectionMenu>.ConfigureCell = { [weak self] _, collectionView, indexPath, item in
        guard let self = self else { return UITableViewCell() }
        switch item {
        case .content(let entity):
            let cell: CollectionMenuTableViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.descriptionView.titleLabel.text = entity.title
            cell.descriptionView.descriptionLabel.text = entity.description
            cell.descriptionView.optionLabel.text = "\(entity.routes.count) routes"
            return cell
        }
    }
}
