//
//  UIKit+Extensions.swift
//  Source
//
//  Created by Stefan Herold on 28.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit

extension UITableViewCell {

    // Adjusting the seperator insets: http://stackoverflow.com/a/39005773/971329
    public func adjustCellSeparatorInsets(_ newInsets: UIEdgeInsets) {

        // removing seperator inset
        if responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            separatorInset = newInsets
        }
        // prevent the cell from inheriting the tableView's margin settings
        if responds(to: #selector(setter: UIView.preservesSuperviewLayoutMargins)) {
            preservesSuperviewLayoutMargins = false
        }
        // explicitly setting cell's layout margins
        if responds(to: #selector(setter: UITableViewCell.layoutMargins)) {
            layoutMargins = newInsets
        }
    }

}
