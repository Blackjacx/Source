//
//  MyConfigurableCell.swift
//  iOS Example
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit
import Sourcery

class MyConfigurableCell: UITableViewCell {
}

extension MyConfigurableCell: Configurable {

    func configureWithItem(_ item: Item) throws {

        guard let myItem = item as? MyItem else { throw SourceryError.invalidItem("\(item)") }

        textLabel?.text = myItem.title
    }
}
