//
//  SingleSectionViewController.swift
//  iOS Example
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit
import Source

class SingleSectionViewController: UIViewController {

    let table = UITableView()
    lazy var dataSource: Source = {
        return Source(with: table)
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()

        var items = [
            MyItem(title: "Einstellungen", action:{ (sender) in print("Einstellungen") }),
            MyItem(title: "Impressung", action:{ (sender) in print("Impressum") }),
            MyItem(title: "Empfehlen", action:{ (sender) in print("Empfehlen") }),
            MyItem(title: "Hilfe", action:{ (sender) in print("Hilfe") }),
            MyItem(title: "Logout", action:{ (sender) in print("Logout") })
        ]

        // Changing the connected cell class for all items. Alternatively you can just create a new item and set another default cell type.
        for index in 0..<items.count {
            items[index].cellType = MyDisclosureCell.self
        }

        let section = MySection(items: items, headerTitle: nil, footerTitle: nil)
        dataSource.collection = ItemCollection(with: [section])
        table.dataSource = dataSource
        table.delegate = self

        table.tableFooterView = UIView()
        table.addMaximizedTo(view)
    }
}

extension SingleSectionViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        let item = dataSource.collection[indexPath]
        item.action?(indexPath)
    }

    // Adjusting the seperator insets: http://stackoverflow.com/a/39005773/971329
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cell.adjustCellSeparatorInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
    }
}
