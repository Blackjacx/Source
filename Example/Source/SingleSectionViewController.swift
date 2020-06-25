//
//  SingleSectionViewController.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit
import Source

final class SingleSectionViewController: UIViewController {

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

        let accessory: UITableViewCell.AccessoryType = .none

        var models = [
            CustomModel(title: "Einstellungen", accessory: accessory, didTap: { (sender) in print("Einstellungen") }),
            CustomModel(title: "Impressung", accessory: accessory, didTap: { (sender) in print("Impressum") }),
            CustomModel(title: "Empfehlen", accessory: accessory, didTap: { (sender) in print("Empfehlen") }),
            CustomModel(title: "Hilfe", accessory: accessory, didTap: { (sender) in print("Hilfe") }),
            CustomModel(title: "Logout", accessory: accessory, didTap: { (sender) in print("Logout") })
        ]
        // Changing the connected cell class for all models. Alternatively you
        // can just create a new model and set another default cell type.
        for index in 0..<models.count {
            models[index].cellType = DefaultCell.self
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

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        dataSource.cellHeightCache[indexPath] ?? UITableView.automaticDimension
    }
}
