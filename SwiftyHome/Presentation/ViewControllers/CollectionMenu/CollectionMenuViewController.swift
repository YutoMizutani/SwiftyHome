//
//  CollectionMenuViewController.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/16.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

class CollectionMenuViewController: UIViewController, StoryboardLoadable {
    typealias ViewModelType = CollectionMenuViewModel

    @IBOutlet weak var collectionView: CollectionMenuCollectionView!

    private var viewModel: ViewModelType?
    private var disposeBag = DisposeBag()

    func inject(viewModel: ViewModelType) {
        self.viewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }

    private func configureViewModel() {
        guard let viewModel = viewModel else { return }

        let fetchTrigger: Driver<Void> = rx.viewDidLoadAndNow.asDriverOnErrorJustComplete()

        _ = viewModel.transform(CollectionMenuViewModel.Input(fetchTrigger: fetchTrigger))

        viewModel.menus
            .bind(to: collectionView.rx.items(dataSource: collectionView.configureDataSource))
            .disposed(by: disposeBag)
    }
}
