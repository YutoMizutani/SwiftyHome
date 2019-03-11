//
//  EditTodoView.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import RxSwift
import UIKit

class EditTodoView: UIView {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!

    var disposeBag = DisposeBag()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        reset()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        reset()
        configureView()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        reset()
        configureView()
    }

    private func reset() {
        titleTextField.text = nil
        descriptionTextView.text = nil
    }

    private func configureView() {
        descriptionTextView.configurePlaceholder("Description")
            .disposed(by: disposeBag)
    }
}
