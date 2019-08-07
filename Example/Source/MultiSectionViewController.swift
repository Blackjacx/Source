//
//  MultiSectionViewController.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import UIKit
import Source

class MultiSectionViewController: UIViewController {

    let table = UITableView()

    var dataSource: Source = Source() {
        didSet {
            dataSource.dataSourceDidChangedClosure = { [weak self] (dataSource) in
                guard let self = self else { return }
                self.dataSource.registerCells(for: self.table)
                self.table.reloadData()
            }
            dataSource.registerCells(for: table)
            table.reloadData()
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()

        let dataSource: Source = {
            let source = Source()
            let sections = [
                MySection(models: [MyModel(title: "Mom"),
                                   MyModel(title: "Dad"),
                                   MyModel(title: "Brother"),
                                   MyModel(title: "Mom"),
                                   MyModel(title: "Dad"),
                                   MyModel(title: "Brother"),
                                   MyModel(title: "Mom"),
                                   MyModel(title: "Dad"),
                                   MyModel(title: "Brother"),
                                   MyModel(title: "Mom"),
                                   MyModel(title: "Dad"),
                                   MyModel(title: "Brother")],
                          headerTitle: "Family",
                          footerTitle: nil),

                MySection(models: [MyModel(title: "Apple"),
                                   MyModel(title: "Banana"),
                                   MyModel(title: "Grape"),
                                   MyModel(title: "Apple"),
                                   MyModel(title: "Banana"),
                                   MyModel(title: "Grape"),
                                   MyModel(title: "Apple"),
                                   MyModel(title: "Banana"),
                                   MyModel(title: "Grape"),
                                   MyModel(title: "Apple"),
                                   MyModel(title: "Banana"),
                                   MyModel(title: "Grape")],
                          headerTitle: "Fruits",
                          footerTitle: nil),

                // No header title -> no section index title
                MySection(models: [MyModel(title: "Apple"),
                                   MyModel(title: "Banana"),
                                   MyModel(title: "Grape"),
                                   MyModel(title: "Apple"),
                                   MyModel(title: "Banana"),
                                   MyModel(title: "Grape"),
                                   MyModel(title: "Apple"),
                                   MyModel(title: "Banana"),
                                   MyModel(title: "Grape"),
                                   MyModel(title: "Apple"),
                                   MyModel(title: "Banana"),
                                   MyModel(title: "Grape")],
                          headerTitle: nil,
                          footerTitle: nil),

                MySection(models: [MyModel(title: "Vampire"),
                                   MyModel(title: "Lycan"),
                                   MyModel(title: "Clown"),
                                   MyModel(title: "God"),
                                   MyModel(title: "Djin"),
                                   MyModel(title: "Vampire"),
                                   MyModel(title: "Lycan"),
                                   MyModel(title: "Clown"),
                                   MyModel(title: "God"),
                                   MyModel(title: "Djin"),
                                   MyModel(title: "Vampire"),
                                   MyModel(title: "Lycan"),
                                   MyModel(title: "Clown"),
                                   MyModel(title: "God"),
                                   MyModel(title: "Djin"),
                                   MyModel(title: "Vampire"),
                                   MyModel(title: "Lycan"),
                                   MyModel(title: "Clown"),
                                   MyModel(title: "God"),
                                   MyModel(title: "Djin")],
                          headerTitle: "Monsters",
                          footerTitle: nil)
            ]

            source.collection = ModelCollection(with: sections)
            return source
        }()
        self.dataSource = dataSource

        table.dataSource = dataSource
        table.delegate = self

        table.tableFooterView = UIView()
        table.addMaximizedTo(view)
    }

    // MARK: - Actions

    @IBAction func toggleSectionIndexTitles(_ sender: Any) {
        dataSource.useSectionIndexTitles = !dataSource.useSectionIndexTitles
    }
}

extension MultiSectionViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        let model = dataSource.collection[indexPath]
        model.didTap?(indexPath)
    }
}
