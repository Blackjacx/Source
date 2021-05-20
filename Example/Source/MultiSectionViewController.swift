//
//  MultiSectionViewController.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2021 Stefan Herold. All rights reserved.
//

import UIKit
import Source

final class MultiSectionViewController: UIViewController {

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

    // swiftlint:disable:next function_body_length
    private func setupDataSource() {

        dataSource.dataSourceDidChangedClosure = { [weak self] (source) in
            guard let self = self else { return }
            source.registerCellsAndSupplementaryViews(for: self.table)
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
                        headerModel: DefaultSupplementaryViewModel(title: "Family")),

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
                      headerModel: DefaultSupplementaryViewModel(title: "Fruits")),

            // No header model -> no section header (estimatedHeightForHeaderInSection has to return 0 for this)
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
                               CustomModel(title: "Grape")]),

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
                      headerModel: DefaultSupplementaryViewModel(title: "Monsters"))
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

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let model = dataSource.collection[section]

        guard let id = model.headerModel?.viewType.reuseIdentifier else {
            return nil
        }

        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: id) as? ConfigurableSupplementaryView else {
            return nil
        }

        do {
            try view.configure(with: model.headerModel)
        } catch {}

        return view
    }

    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        dataSource.collection[section].headerModel == nil ? 0 : 50
    }
}
