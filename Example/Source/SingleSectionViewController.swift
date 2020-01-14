//
//  SingleSectionViewController.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import UIKit
import Source

class SingleSectionViewController: UIViewController {

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

    private func setupDataSource() {

        dataSource.dataSourceDidChangedClosure = { [weak self] (source) in
            guard let self = self else { return }
            source.registerCells(for: self.table)
            self.table.reloadData()
        }

        var models = [
            MyModel(title: "Einstellungen", didTap: { (sender) in print("Einstellungen") }),
            MyModel(title: "Impressung", didTap: { (sender) in print("Impressum") }),
            MyModel(title: "Empfehlen", didTap: { (sender) in print("Empfehlen") }),
            MyModel(title: "Hilfe", didTap: { (sender) in print("Hilfe") }),
            MyModel(title: "Logout", didTap: { (sender) in print("Logout") })
        ]
        // Changing the connected cell class for all models. Alternatively you
        // can just create a new model and set another default cell type.
        for index in 0..<models.count {
            models[index].cellType = MyDisclosureCell.self
        }
        dataSource.collection = ModelCollection(models: models)
    }
}

extension SingleSectionViewController: UITableViewDelegate {

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
