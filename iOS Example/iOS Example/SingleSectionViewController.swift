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

        var items = [MyItem(title: "Einstellungen"), MyItem(title: "Impressung"), MyItem(title: "Empfehlen"), MyItem(title: "Hilfe"), MyItem(title: "Logout")]

        // Changing the connected cell class for all items. Alternatively you can just create a new item and set another default cell type.
        for index in 0..<items.count {
            items[index].cellClass = MyDisclosureCell.self
        }

        let section = MySection(items: items, headerTitle: nil, footerTitle: nil)
        dataSource.collection = ItemCollection(with: [section])
        table.dataSource = dataSource

        table.tableFooterView = UIView()
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)

        setupLayoutConstraints()
    }

    private func setupLayoutConstraints() {

        let constraints = [
            table.leftAnchor.constraint(equalTo: view.leftAnchor),
            table.rightAnchor.constraint(equalTo: view.rightAnchor),
            table.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            table.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

