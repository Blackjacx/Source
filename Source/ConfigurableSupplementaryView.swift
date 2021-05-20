//
//  ConfigurableHeaderFooter.swift
//  Source
//
//  Created by Stefan Herold on 10.08.20.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit

public protocol ConfigurableSupplementaryView: UIView {

    /// Configures your section header/footer using a view model.
    /// - parameters:
    ///   - model: The view model that configures the supplementary view.
    /// - note: This protocol must be a class-based protocol because `tableView.register` requires `AnyClass`.
    /// - throws: Throw an error when you receive an unexpected `SupplementaryViewModel`
    func configure(with model: SupplementaryViewModel?) throws
}
