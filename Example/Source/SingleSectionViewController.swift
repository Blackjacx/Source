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

    private static let data: [String] = ["Settings", "Imprint", "Recommendation", "Help", "Logout"]

    let table = UITableView()
    let dataSource = DataSource()

    override func viewDidLoad() {

        super.viewDidLoad()

        table.dataSource = dataSource
        table.delegate = self

        table.tableFooterView = UIView()
        table.addMaximizedTo(view)

        setupDataSource()

        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(onAdd(sender:)))
        navigationItem.rightBarButtonItem = addButton
    }

    @objc func onAdd(sender: UIBarButtonItem) {

        let title = Self.data.randomElement()!
        let model = CustomModel(title: title, didTap: { (sender) in print(title) })
        let indexPath = IndexPath(row: dataSource.collection[0].count, section: 0)
        dataSource.collection.insertRow(item: model, at: indexPath)
    }

    private func setupDataSource() {

        dataSource.dataSourceDidChangedClosure = { [weak self] (source) in
            guard let self = self else { return }
            source.registerCellsAndSupplementaryViews(for: self.table)
            self.table.reloadData()
        }

        var models = Self.data.map { title in
            CustomModel(title: title, accessory: .none, didTap: { (sender) in print(title) })
        }

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
