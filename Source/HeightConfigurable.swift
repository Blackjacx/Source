//
//  HeightConfigurable.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit

/// Protocol that additionally to `Configurable` requires a `height` property.
public protocol HeightConfigurable: Configurable {

    /// Should return the calculated height of the cell or
    /// `UITableView.automaticDimension` if height can be determined
    /// automatically.
    var height: CGFloat { get }
}
