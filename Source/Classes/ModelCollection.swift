//
//  ModelCollection.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit

public struct ModelCollection {

    private var sections: [Section]

    var sectionsWithIndexTitles: [(section: Int, indexTitle: String)] {
        sections.enumerated().compactMap {
            guard let title = $0.element.headerTitle else { return nil }
            return ($0.offset, title)
        }
    }

    public init() {
        self.sections = []
    }

    public init(sections: [Section]) {
        self.sections = sections
    }

    public init(models: [ViewModel]) {
        self.sections = [DefaultSection(models: models)]
    }

    public var sectionCount: Int {
        sections.count
    }

    public var allModels: [ViewModel] {
        sections.flatMap { $0.models }
    }

    public func rowsForSection(_ section: Int) -> Int {
        sections[section].count
    }

    public func isInBounds(_ indexPath: IndexPath) -> Bool {

        // Checking for `isEmpty` is necessary since `.section` is an alias for
        // the internal array _indexes[0] which will crash if the indexPath is
        // empty.
        // See https://stackoverflow.com/a/17182239/971329
        guard !indexPath.isEmpty,
            0 <= indexPath.section && indexPath.section < sections.count,
            0 <= indexPath.row && indexPath.row < rowsForSection(indexPath.section) else {

                return false
        }
        return true
    }

    public func indexPath(for model: ViewModel) -> IndexPath? {
        for (sectionIndex, section) in sections.enumerated() {
            for (rowIndex, dataSourceModel) in section.models.enumerated() where model == dataSourceModel {
                return IndexPath(row: rowIndex, section: sectionIndex)
            }
        }
        return nil
    }

    public mutating func addSection(_ section: Section) {
        sections.append(section)
    }

    public mutating func removeSection(at index: Int) {
        sections.remove(at: index)
    }

    public mutating func removeRow(at indexPath: IndexPath) {
        guard isInBounds(indexPath) else { return }
        sections[indexPath.section].remove(at: indexPath.row)
    }

    public subscript(index: Int) -> Section {
        sections[index]
    }

    public subscript(indexPath: IndexPath) -> ViewModel {
        sections[indexPath.section][indexPath.row]
    }
}
