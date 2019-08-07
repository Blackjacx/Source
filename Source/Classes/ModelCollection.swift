//
//  ModelCollection.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import UIKit

public struct ModelCollection {

    private var sections: [Section]

    var sectionsWithIndexTitles: [(section: Int, indexTitle: String)] {
        return sections.enumerated().compactMap {
            guard let title = $0.element.headerTitle else {return nil}
            return ($0.offset, title)
        }
    }

    public init(with initialSections: [Section] = []) {
        sections = initialSections
    }

    public var sectionCount: Int {
        return sections.count
    }

    public var allModels: [ViewModel] {
        return sections.flatMap { $0.models }
    }

    public func rowsForSection(_ section: Int) -> Int {
        return sections[section].count
    }

    public func isInBounds(_ indexPath: IndexPath) -> Bool {
        guard 0 <= indexPath.section && indexPath.section < sections.count else {
            return false
        }
        guard 0 <= indexPath.row && indexPath.row < rowsForSection(indexPath.section) else {
            return false
        }
        return true
    }

    public func indexPath(for model: ViewModel) -> IndexPath? {
        for (sectionIndex, section) in sections.enumerated() {
            for (rowIndex, dataSourceModel) in section.models.enumerated() {
                if model == dataSourceModel {
                    return IndexPath(row: rowIndex, section: sectionIndex)
                }
            }
        }
        return nil
    }

    public mutating func addSection(_ section: Section) {
        sections.append(section)
    }

    public subscript(index: Int) -> Section {
        return sections[index]
    }

    public subscript(indexPath: IndexPath) -> ViewModel {
        return sections[indexPath.section][indexPath.row]
    }
}
