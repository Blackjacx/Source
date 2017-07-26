//
//  ItemCollection.swift
//  Sourcery
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import Foundation
import UIKit

public struct ItemCollection {

    private var sections: [Section]

    var sectionsWithIndexTitles: [(section: Int, indexTitle: String)] {
        return sections.enumerated().flatMap {
            guard let title = $0.element.headerTitle else {return nil}
            return ($0.offset, title)
        }
    }

    public init(with initialSections: [Section] = []) {
        sections = initialSections
    }
}

extension ItemCollection {
    
    public func sectionCount() -> Int {
        return sections.count
    }

    public func rowsForSection(_ section: Int) -> Int {
        return sections[section].count
    }

    public mutating func addSection(_ section: Section) {

        sections.append(section)
    }

    public subscript(index: Int) -> Section {

        return sections[index]
    }

    public subscript(indexPath: IndexPath) -> Item {

        return sections[indexPath.section][indexPath.row]
    }

    func registerCellsInTableView(_ table: UITableView) {

        let allItems = sections.flatMap { $0.items }
        
        allItems.forEach {
            table.register($0.reusableType as? AnyClass, forCellReuseIdentifier: $0.reusableType.reuseIdentifier)
        }
    }
}
