//
//  ItemCollection.swift
//  Sourcery
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import Foundation

struct ItemCollection {

    private let collation = UILocalizedIndexedCollation.current()
    private var sections: [Section] = []

    var sectionsWithIndexTitles: [(section: Int, indexTitle: String)] {
        return sections.enumerated().flatMap {
            guard let title = $0.element.headerTitle else {return nil}
            return ($0.offset, title)
        }
    }

    func sectionCount() -> Int {
        return sections.count
    }

    func rowsForSection(_ section: Int) -> Int {
        return sections[section].count
    }

    func itemAtIndexPath(_ indexPath: IndexPath) -> Item {
        return sections[indexPath.section][indexPath.row]
    }
}

extension ItemCollection {

    subscript(index: Int) -> Section {

        get { return sections[index] }
        set(newValue) { sections[index] = newValue }
    }

    subscript(indexPath: IndexPath) -> Item {

        get { return sections[indexPath.section][indexPath.row] }
        set(newValue) { sections[indexPath.section][indexPath.row] = newValue }
    }
}
