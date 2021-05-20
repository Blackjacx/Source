//
//  ModelCollection.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import Foundation

public struct ModelCollection {

    private(set) var sections: [Section]

    var sectionsWithIndexTitles: [(section: Int, indexTitle: String)] {
        sections.enumerated().compactMap {
            guard let title = $0.element.headerModel?.title, !title.isEmpty else { return nil }
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

        // Checking for `isEmpty` is necessary since `.section` is an alias for the internal array _indexes[0] which
        // will crash if the indexPath is empty. See https://stackoverflow.com/a/17182239/971329
        guard !indexPath.isEmpty,
            0 <= indexPath.section && indexPath.section < sections.count,
            0 <= indexPath.row && indexPath.row < rowsForSection(indexPath.section) else {

                return false
        }
        return true
    }

    /// The difference to `isInBounds` is that `indexPath` can actually match section.rows.count since iOS can insert
    /// in array at this position without crashing.
    /// - parameter indexPath: The indexPath for to check. Permitted values are
    /// ([0...sections.count], [0...sections[indexPath.section].count]).
    public func isInBoundsForInsertion(_ indexPath: IndexPath) -> Bool {

        // Checking for `isEmpty` is necessary since `.section` is an alias for the internal array _indexes[0] which
        // will crash if the indexPath is empty. See https://stackoverflow.com/a/17182239/971329
        guard !indexPath.isEmpty,
            0 <= indexPath.section && indexPath.section < sections.count,
            0 <= indexPath.row && indexPath.row <= rowsForSection(indexPath.section) else {

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

    /// This function can insert new rows in and at the end of each section. BUT it cannot append a new section.
    /// In that case the function just returns. To achieve that you have to generate a new section instance of your
    /// implementation of the Section protocol, add the row to it and add the whole new section.
    public mutating func insertRow(item: ViewModel, at indexPath: IndexPath) {
        guard isInBoundsForInsertion(indexPath) else { return }
        sections[indexPath.section].insert(item: item, at: indexPath.row)
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
