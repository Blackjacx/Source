//
//  ImageListViewController.swift
//  Source_Example
//
//  Created by Stefan Herold on 14.02.20.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit
import Source

final class ImageListViewController: UIViewController {

    let table = UITableView()
    let dataSource = Source()

    override func viewDidLoad() {

        super.viewDidLoad()

        table.dataSource = dataSource
        table.delegate = self

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
            ImageModel(image: UIImage(named: "image1")!),
            ImageModel(image: UIImage(named: "image2")!),
            ImageModel(image: UIImage(named: "image3")!),
            ImageModel(image: UIImage(named: "image4")!)
        ]

        let sections = [
            DefaultSection(models: models, headerTitle: nil, footerTitle: nil)
        ]
        dataSource.collection = ModelCollection(sections: sections)
    }
}

extension ImageListViewController: UITableViewDelegate {

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
