//
//  CollectionMenuCollectionView.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxDataSources
import RxSwift
import UIKit

class CollectionMenuCollectionViewDelegate: NSObject, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    static let shared = CollectionMenuCollectionViewDelegate()

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
}

class CollectionMenuCollectionView: UICollectionView {
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
        register(CollectionMenuCollectionViewCell.nib, forCellWithReuseIdentifier: CollectionMenuCollectionViewCell.reuseIdentifier)
    }

    private func layoutView() {
    }

    private func binding() {
        rx.setDelegate(CollectionMenuCollectionViewDelegate.shared)
            .disposed(by: disposeBag)
    }

    lazy var configureDataSource = RxCollectionViewSectionedReloadDataSource<SectionOfCollectionMenu>(configureCell: configureCell)

    lazy var configureCell: RxCollectionViewSectionedReloadDataSource<SectionOfCollectionMenu>.ConfigureCell = { [weak self] _, collectionView, indexPath, item in
        guard let self = self else { return UICollectionViewCell() }
        switch item {
        case .content(let entity):
            let cell: CollectionMenuCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.descriptionView.titleLabel.text = entity.title
            cell.descriptionView.descriptionLabel.text = entity.description
            cell.descriptionView.optionLabel.text = entity.option
            return cell
        }
    }
}
