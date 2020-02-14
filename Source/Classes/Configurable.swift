//
//  Configurable.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit

public typealias DidCalculateHeightClosure = (_ height: CGFloat) -> Void

public protocol Configurable: class {

    /// Configures your cell using a view model.
    /// - parameters:
    ///   - model: The view model that configures the cell.
    ///   - didCalculateHeight: The completion handler that has to be called
    ///   when the cell knows its height. It is used to specify the correct
    ///   height of the cell in its delegate function, e.g. when your cell
    ///   displays an imaged async loaded from the internet autolayout doesn't
    ///   help you anymore. You have to specify the correct height of the cell
    ///   in `tableView(_:, heightForRowAt:)`.
    /// - note: This protocol must be a class-based protocol because
    /// `tableView.register` requires `AnyClass`.
    /// - throws: Throw an error when you receive an unexpected `ViewModel`
    func configure(with model: ViewModel?,
                   didCalculateHeight: @escaping DidCalculateHeightClosure) throws
}
