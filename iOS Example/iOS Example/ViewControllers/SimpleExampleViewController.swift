//
//  SimpleExampleViewController.swift
//  iOS Example
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit
import Sourcery

class SimpleExampleViewController: UIViewController {

    let table = UITableView()
    lazy var dataSource: Sourcery = {
        return Sourcery(with: table)
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()

        let items = [
            MyItem(title: "Einstellungen", action:{ print("Einstellungen") }),
            MyItem(title: "Hilfe", action:{ print("Hilfe") }),
            MyItem(title: "Logout", action:{ print("Logout") })
        ]

        let section = MySection(items: items, headerTitle: nil, footerTitle: nil)
        dataSource.collection = ItemCollection(with: [section])
        table.dataSource = dataSource

        table.delegate = self
        table.tableFooterView = UIView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.addMaximizedTo(view)
    }
}

extension SimpleExampleViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let item = dataSource.collection[indexPath]
        item.action?()
    }
}
