//
//  Configurable.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2021 Stefan Herold. All rights reserved.
//

import Foundation

public protocol Configurable: AnyObject {

    /// Configures your cell using a view model.
    /// - parameters:
    ///   - model: The view model that configures the cell.
    /// - note: This protocol must be a class-based protocol because `tableView.register` requires `AnyClass`.
    /// - throws: Throw an error when you receive an unexpected `ViewModel`
    func configure(with model: ViewModel?) throws
}
