//
//  UITableViewCell+Extensions.swift
//  Source
//
//  Created by Stefan Herold on 07.08.19.
//  Copyright © 2024 Stefan Herold. All rights reserved.
//

import UIKit

public extension UITableViewCell {

    func adjustCellSeparatorInsets(at indexPath: IndexPath,
                                   for modelCollection: ModelCollection,
                                   numberOfLastSeparatorsToHide: Int) {

        guard modelCollection.isInBounds(indexPath) else { return }

        let model = modelCollection[indexPath]
        var insets = model.separatorInsets
        let lastSection = modelCollection[modelCollection.sectionCount - 1]
        let shouldHideSeparator = indexPath.section == modelCollection.sectionCount - 1
            && indexPath.row >= lastSection.count - numberOfLastSeparatorsToHide

        // Don't show the separator for the last N rows of the last section
        if shouldHideSeparator {
            insets = NSDirectionalEdgeInsets(top: 0, leading: 9999, bottom: 0, trailing: 0)
        }

        // removing separator inset
        separatorInset = insets.edgeInsets

        // prevent the cell from inheriting the tableView's margin settings
        preservesSuperviewLayoutMargins = false
    }
}
