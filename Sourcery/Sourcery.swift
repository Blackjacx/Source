//
//  Sourcery.swift
//  Sourcery
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit

public class Sourcery: NSObject {

    var collection: ItemCollection = ItemCollection()
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

        (cell as? Configurable)?.configureWithItem(item)

        return cell
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return collection[section].headerTitle
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return collection[section].footerTitle
    }

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
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
