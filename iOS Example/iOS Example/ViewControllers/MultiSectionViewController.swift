//
//  MultiSectionViewController.swift
//  iOS Example
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit
import Sourcery

class MultiSectionViewController: UIViewController {

    let table = UITableView()
    lazy var dataSource: Sourcery = {
        return Sourcery(with: table)
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()

        let sections = [
            MySection(items: [MyItem(title: "Mom"), MyItem(title: "Dad"), MyItem(title: "Brother"), MyItem(title: "Mom"), MyItem(title: "Dad"), MyItem(title: "Brother"), MyItem(title: "Mom"), MyItem(title: "Dad"), MyItem(title: "Brother"), MyItem(title: "Mom"), MyItem(title: "Dad"), MyItem(title: "Brother")], headerTitle: "Family", footerTitle: nil),
            
            MySection(items: [MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape")], headerTitle: "Fruits", footerTitle: nil),

            // No header title -> no section index title
            MySection(items: [MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape")], headerTitle: nil, footerTitle: nil),

            MySection(items: [MyItem(title: "Vampire"), MyItem(title: "Lycan"), MyItem(title: "Clown"), MyItem(title: "God"), MyItem(title: "Djin"), MyItem(title: "Vampire"), MyItem(title: "Lycan"), MyItem(title: "Clown"), MyItem(title: "God"), MyItem(title: "Djin"), MyItem(title: "Vampire"), MyItem(title: "Lycan"), MyItem(title: "Clown"), MyItem(title: "God"), MyItem(title: "Djin"), MyItem(title: "Vampire"), MyItem(title: "Lycan"), MyItem(title: "Clown"), MyItem(title: "God"), MyItem(title: "Djin")], headerTitle: "Monsters", footerTitle: nil)
        ]

        dataSource.collection = ItemCollection(with: sections)
        table.dataSource = dataSource
        table.delegate = dataSource

        table.tableFooterView = UIView()
        table.addMaximizedTo(view)
    }

    // MARK: - Actions

    @IBAction func toggleSectionIndexTitles(_ sender: Any) {
        dataSource.useSectionIndexTitles = !dataSource.useSectionIndexTitles
    }
}
