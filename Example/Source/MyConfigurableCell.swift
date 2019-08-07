//
//  MyConfigurableCell.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import UIKit
import Source

class MyConfigurableCell: UITableViewCell, Reusable {
}

extension MyConfigurableCell: Configurable {

    func configure(with model: ViewModel?) throws {
        guard let myModel = model as? MyModel else { throw Source.Error.invalidModel(model) }
        textLabel?.text = myModel.title
    }
}
