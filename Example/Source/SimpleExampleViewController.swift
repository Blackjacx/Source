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

    var dataSource: Source = Source() {
        didSet {
            dataSource.dataSourceDidChangedClosure = { [weak self] (dataSource) in
                guard let self = self else { return }
                dataSource.registerCells(for: self.table)
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
            let models = [
                MyModel(title: "Einstellungen", didTap: { (sender) in print("Einstellungen") }),
                MyModel(title: "Hilfe", didTap: { (sender) in print("Hilfe") }),
                MyModel(title: "Logout", didTap: { (sender) in print("Logout") })
            ]
            let section = MySection(models: models, headerTitle: nil, footerTitle: nil)
            source.collection = ModelCollection(with: [section])
            return source
        }()
        self.dataSource = dataSource

        table.dataSource = dataSource
        table.delegate = self
        
        table.tableFooterView = UIView()
        table.addMaximizedTo(view)


        self.dataSource = dataSource
    }
}

extension SimpleExampleViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        let model = dataSource.collection[indexPath]
        model.didTap?(indexPath)
    }
}
