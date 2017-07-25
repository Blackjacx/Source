//
//  Sourcery.swift
//  Sourcery
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit

public enum SourceryError: Error {

    case invalidItem(String)
    case configurableExpected(String)
}

public class Sourcery: NSObject {

    public var collection: ItemCollection = ItemCollection() {

        didSet {
            collection.registerCellsInTableView(tableView)
            tableView.reloadData()
        }
    }
    
    public var useSectionIndexTitles = true {

        didSet {
            tableView.reloadData()
        }
    }

    let tableView: UITableView

    @available(*, unavailable, message:"init() has not been implemented")
    override init() {
        fatalError()
    }

    public init(with table: UITableView) {
        tableView = table
        super.init()
    }
}

extension Sourcery: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        return collection.sectionCount()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collection.rowsForSection(section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = collection[indexPath]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: indexPath)

        do {
            guard let configurable = cell as? Configurable else {
                throw SourceryError.configurableExpected("\(type(of: cell)) expected to confirm to Configurable!")
            }
            try configurable.configureWithItem(item)
        } catch {
            assertionFailure("\(error)")
        }

        return cell
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collection[section].headerTitle
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return collection[section].footerTitle
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard useSectionIndexTitles else {return nil}
        return collection.sectionsWithIndexTitles.flatMap { $0.indexTitle }
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return collection.sectionsWithIndexTitles[index].section
    }


//    optional public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
//    optional public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool
//    optional public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
//    optional public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath)
}
