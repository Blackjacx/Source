//
//  ViewController.swift
//  iOS Example
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit
import Sourcery

class ViewController: UIViewController {

    let table = UITableView()
    lazy var dataSource: Sourcery = {
        return Sourcery(with: table)
    }()

    override func viewDidLoad() {
        
        super.viewDidLoad()

        let sections = [
            MySection(sortOrder: 0, items: [MyItem(title: "A"), MyItem(title: "B"), MyItem(title: "C")], headerTitle: nil, footerTitle: nil),

            MySection(sortOrder: 0, items: [MyItem(title: "Mom"), MyItem(title: "Dad"), MyItem(title: "Brother"), MyItem(title: "Mom"), MyItem(title: "Dad"), MyItem(title: "Brother"), MyItem(title: "Mom"), MyItem(title: "Dad"), MyItem(title: "Brother"), MyItem(title: "Mom"), MyItem(title: "Dad"), MyItem(title: "Brother")], headerTitle: "Family", footerTitle: nil),
            
            MySection(sortOrder: 0, items: [MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape")], headerTitle: "Fruits", footerTitle: nil),

            // No header title -> no section index title
            MySection(sortOrder: 0, items: [MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape"), MyItem(title: "Apple"), MyItem(title: "Banana"), MyItem(title: "Grape")], headerTitle: nil, footerTitle: nil),

            MySection(sortOrder: 0, items: [MyItem(title: "Vampire"), MyItem(title: "Lycan"), MyItem(title: "Clown"), MyItem(title: "God"), MyItem(title: "Djin"), MyItem(title: "Vampire"), MyItem(title: "Lycan"), MyItem(title: "Clown"), MyItem(title: "God"), MyItem(title: "Djin"), MyItem(title: "Vampire"), MyItem(title: "Lycan"), MyItem(title: "Clown"), MyItem(title: "God"), MyItem(title: "Djin"), MyItem(title: "Vampire"), MyItem(title: "Lycan"), MyItem(title: "Clown"), MyItem(title: "God"), MyItem(title: "Djin")], headerTitle: "Monsters", footerTitle: nil)
        ]

        dataSource.collection = ItemCollection(with: sections)

        table.dataSource = dataSource
        table.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(table)

        table.reloadData()

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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions

    @IBAction func toggleSectionIndexTitles(_ sender: Any) {
        dataSource.useSectionIndexTitles = !dataSource.useSectionIndexTitles
    }
}

