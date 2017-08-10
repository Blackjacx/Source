//
//  MyItem.swift
//  iOS Example
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import Foundation
import Source

struct MyItem: Item {
    var title: String
    var cellType: (Configurable & Reusable).Type = MyConfigurableCell.self
    var action: CellAction?
}

extension MyItem {

    init(title: String, action: CellAction? = nil) {
        self.title = title
        self.action = action
    }
}
