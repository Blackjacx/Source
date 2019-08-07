//
//  Source.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import UIKit

public typealias DataSourceDidChangedClosure = (_ dataSource: Source) -> Void

public final class Source: NSObject {

    public enum Error: Swift.Error {
        case invalidModel(ViewModel?)
    }

    public var collection: ModelCollection = ModelCollection() {
        didSet {
            dataSourceDidChangedClosure?(self)
        }
    }

    public var useSectionIndexTitles = true {
        didSet {
            dataSourceDidChangedClosure?(self)
        }
    }

    public var dataSourceDidChangedClosure: DataSourceDidChangedClosure?

    public func registerCells(for table: UITableView) {
        collection.allModels.forEach {
            table.register($0.cellType, forCellReuseIdentifier: $0.cellType.reuseIdentifier)
        }
    }
}

extension Source: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return collection.sectionCount
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.rowsForSection(section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let model = collection[indexPath]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellType.reuseIdentifier, for: indexPath)

        cell.selectionStyle = model.didTap == nil ? .none : .default

        do {
            try (cell as? Configurable)?.configure(with: model)
        } catch {
            fatalError("\(error)")
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        guard collection.isInBounds(indexPath) else {
            return false
        }
        return collection[indexPath].didDelete != nil
    }

    // MARK: - Section Index Titles

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collection[section].headerTitle
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return collection[section].footerTitle
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard useSectionIndexTitles else {return nil}
        return collection.sectionsWithIndexTitles.compactMap { $0.indexTitle }
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return collection.sectionsWithIndexTitles[index].section
    }

    // TODO: Implement the following datasource methods
//    optional public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
//    optional public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
//    optional public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
//    optional public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}
