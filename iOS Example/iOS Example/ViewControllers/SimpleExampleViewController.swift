//
//  SimpleExampleViewController.swift
//  iOS Example
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit
import Source

class SimpleExampleViewController: UIViewController {

    let table = UITableView()
    lazy var dataSource: Source = {
        return Source(with: table)
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()

        let items = [
            MyItem(title: "Einstellungen", action:{ (sender) in print("Einstellungen") }),
            MyItem(title: "Hilfe", action:{ (sender) in print("Hilfe") }),
            MyItem(title: "Logout", action:{ (sender) in print("Logout") })
        ]

        let section = MySection(items: items, headerTitle: nil, footerTitle: nil)
        dataSource.collection = ItemCollection(with: [section])
        table.dataSource = dataSource
        table.delegate = self
        
        table.tableFooterView = UIView()
        table.addMaximizedTo(view)
    }
}

extension SimpleExampleViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        let item = dataSource.collection[indexPath]
        item.action?(indexPath)
    }
}
