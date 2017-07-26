//
//  MyDisclosureCell.swift
//  iOS Example
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit
import Source

class MyDisclosureCell: UITableViewCell, Reusable {
}

extension MyDisclosureCell: Configurable {

    func configureWithItem(_ item: Item) throws {

        guard let myItem = item as? MyItem else { throw SourceError.invalidItem("\(item)") }

        accessoryType = .disclosureIndicator
        textLabel?.text = myItem.title
    }
}
