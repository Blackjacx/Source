//
//  SimpleExampleViewController.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import UIKit
import Source

class SimpleExampleViewController: UIViewController {

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

        let models = [
            MyModel(title: "Einstellungen", didTap: { (sender) in print("Einstellungen") }),
            MyModel(title: "Hilfe", didTap: { (sender) in print("Hilfe") }),
            MyModel(title: "Logout", didTap: { (sender) in print("Logout") })
        ]
        let section = DefaultSection(models: models)
        dataSource.collection = ModelCollection(with: [section])
    }
}

extension SimpleExampleViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        let model = dataSource.collection[indexPath]
        model.didTap?(indexPath)
    }
}