//
//  Sourcery.swift
//  Sourcery
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit

public class Sourcery: NSObject {

    var items: ItemCollection = ItemCollection()
}

extension Sourcery: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {

        return items.sectionCount()
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return items.rowsForSection(section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let item = items.itemAtIndexPath(indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: item.reuseIdentifier, for: indexPath)

        (cell as? Configurable)?.configureWithItem(item)

        return cell
    }
}
