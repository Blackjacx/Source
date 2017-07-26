//
//  SingleSectionViewController.swift
//  iOS Example
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit
import Sourcery

class SingleSectionViewController: UIViewController {

    let table = UITableView()
    lazy var dataSource: Sourcery = {
        return Sourcery(with: table)
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()

        var items = [
            MyItem(title: "Einstellungen", action:{ print("Einstellungen") }),
            MyItem(title: "Impressung", action:{ print("Impressum") }),
            MyItem(title: "Empfehlen", action:{ print("Empfehlen") }),
            MyItem(title: "Hilfe", action:{ print("Hilfe") }),
            MyItem(title: "Logout", action:{ print("Logout") })
        ]

        // Changing the connected cell class for all items. Alternatively you can just create a new item and set another default cell type.
        for index in 0..<items.count {
            items[index].reusableType = MyDisclosureCell.self
        }

        let section = MySection(items: items, headerTitle: nil, footerTitle: nil)
        dataSource.collection = ItemCollection(with: [section])
        table.dataSource = dataSource

        table.delegate = self
        table.tableFooterView = UIView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.addMaximizedTo(view)
    }
}

extension SingleSectionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = dataSource.collection[indexPath]
        item.action?()
    }
}
