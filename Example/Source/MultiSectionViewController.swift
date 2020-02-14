//
//  MultiSectionViewController.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit
import Source

class MultiSectionViewController: UIViewController {

    let table = UITableView()
    let dataSource = Source()

    override func viewDidLoad() {

        super.viewDidLoad()

        table.dataSource = dataSource
        table.delegate = self

        table.tableFooterView = UIView()
        table.addMaximizedTo(view)

        setupDataSource()
    }

    // swiftlint:disable:next function_body_length
    private func setupDataSource() {

        dataSource.dataSourceDidChangedClosure = { [weak self] (source) in
            guard let self = self else { return }
            source.registerCells(for: self.table)
            self.table.reloadData()
        }

        let sections = [
            DefaultSection(models: [MyModel(title: "Mom"),
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

            DefaultSection(models: [MyModel(title: "Apple"),
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
            DefaultSection(models: [MyModel(title: "Apple"),
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

            DefaultSection(models: [MyModel(title: "Vampire"),
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
        dataSource.collection = ModelCollection(sections: sections)
    }

    // MARK: - Actions

    @IBAction func toggleSectionIndexTitles(_ sender: Any) {
        dataSource.useSectionIndexTitles.toggle()
    }
}

extension MultiSectionViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        let model = dataSource.collection[indexPath]
        model.didTap?(indexPath)
    }

    // Adjusting the seperator insets: http://stackoverflow.com/a/39005773/971329
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.adjustCellSeparatorInsets(at: indexPath,
                                       for: dataSource.collection,
                                       numberOfLastSeparatorsToHide: dataSource.numberOfLastSeparatorsToHide)
    }
}
