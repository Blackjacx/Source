//
//  ItemCollection.swift
//  Sourcery
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import Foundation

struct ItemCollection {

    var collection: [[Item]] = []

    func sectionCount() -> Int {
        return collection.count
    }

    func rowsForSection(_ section: Int) -> Int {
        return collection[section].count
    }

    func itemAtIndexPath(_ indexPath: IndexPath) -> Item {
        return collection[indexPath.section][indexPath.row]
    }
}
