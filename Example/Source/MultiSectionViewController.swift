//
//  MultiSectionViewController.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit
import Source

final class MultiSectionViewController: UIViewController {

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
            DefaultSection(models: [CustomModel(title: "Mom"),
                               CustomModel(title: "Dad"),
                               CustomModel(title: "Brother"),
                               CustomModel(title: "Mom"),
                               CustomModel(title: "Dad"),
                               CustomModel(title: "Brother"),
                               CustomModel(title: "Mom"),
                               CustomModel(title: "Dad"),
                               CustomModel(title: "Brother"),
                               CustomModel(title: "Mom"),
                               CustomModel(title: "Dad"),
                               CustomModel(title: "Brother")],
                      headerTitle: "Family",
                      footerTitle: nil),

            DefaultSection(models: [CustomModel(title: "Apple"),
                               CustomModel(title: "Banana"),
                               CustomModel(title: "Grape"),
                               CustomModel(title: "Apple"),
                               CustomModel(title: "Banana"),
                               CustomModel(title: "Grape"),
                               CustomModel(title: "Apple"),
                               CustomModel(title: "Banana"),
                               CustomModel(title: "Grape"),
                               CustomModel(title: "Apple"),
                               CustomModel(title: "Banana"),
                               CustomModel(title: "Grape")],
                      headerTitle: "Fruits",
                      footerTitle: nil),

            // No header title -> no section index title
            DefaultSection(models: [CustomModel(title: "Apple"),
                               CustomModel(title: "Banana"),
                               CustomModel(title: "Grape"),
                               CustomModel(title: "Apple"),
                               CustomModel(title: "Banana"),
                               CustomModel(title: "Grape"),
                               CustomModel(title: "Apple"),
                               CustomModel(title: "Banana"),
                               CustomModel(title: "Grape"),
                               CustomModel(title: "Apple"),
                               CustomModel(title: "Banana"),
                               CustomModel(title: "Grape")],
                      headerTitle: nil,
                      footerTitle: nil),

            DefaultSection(models: [CustomModel(title: "Vampire"),
                               CustomModel(title: "Lycan"),
                               CustomModel(title: "Clown"),
                               CustomModel(title: "God"),
                               CustomModel(title: "Djin"),
                               CustomModel(title: "Vampire"),
                               CustomModel(title: "Lycan"),
                               CustomModel(title: "Clown"),
                               CustomModel(title: "God"),
                               CustomModel(title: "Djin"),
                               CustomModel(title: "Vampire"),
                               CustomModel(title: "Lycan"),
                               CustomModel(title: "Clown"),
                               CustomModel(title: "God"),
                               CustomModel(title: "Djin"),
                               CustomModel(title: "Vampire"),
                               CustomModel(title: "Lycan"),
                               CustomModel(title: "Clown"),
                               CustomModel(title: "God"),
                               CustomModel(title: "Djin")],
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        dataSource.cellHeightCache[indexPath] ?? UITableView.automaticDimension
    }
}
