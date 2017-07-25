//
//  MyItem.swift
//  iOS Example
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import Foundation
import Sourcery

struct MyItem: Item {

    var title: String
    var cellClass: AnyClass { return MyConfigurableCell.self }
}
