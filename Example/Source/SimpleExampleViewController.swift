//
//  SimpleExampleViewController.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit
import Source

final class SimpleExampleViewController: UIViewController {

    let table = UITableView()
    let dataSource = DataSource()

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
            source.registerCellsAndSupplementaryViews(for: self.table)
            self.table.reloadData()
        }

        let models = [
            CustomModel(title: "Einstellungen", didTap: { (sender) in print("Einstellungen") }),
            CustomModel(title: "Hilfe", didTap: { (sender) in print("Hilfe") }),
            CustomModel(title: "Logout", didTap: { (sender) in print("Logout") })
        ]
        dataSource.collection = ModelCollection(models: models)
    }
}

extension SimpleExampleViewController: UITableViewDelegate {

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
