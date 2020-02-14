//
//  Configurable.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import Foundation

/// Provide a configure with `ViewModel` function.
/// - note: This protocol must be a class-based protocol because
/// `tableView.register` requires `AnyClass`.
public protocol Configurable: class {
    func configure(with model: ViewModel?) throws
}
