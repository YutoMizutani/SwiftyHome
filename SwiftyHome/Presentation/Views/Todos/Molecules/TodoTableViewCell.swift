//
//  TodoTableViewCell.swift
//  SwiftyHome
//
//  Created by Yuto Mizutani on 2019/02/24.
//  Copyright © 2019 Yuto Mizutani. All rights reserved.
//

import UIKit

class TodoTableViewCell: UITableViewCell, NibLoadable {
    @IBOutlet weak var todoView: TodoView!

    var state: TodoState = .disabled {
        didSet {
            todoView?.stateImageView.image = state.image
        }
    }
}
