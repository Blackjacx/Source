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
            ImageModel(url: URL(string: "https://mcdn.wallpapersafari.com/medium/47/47/8b2sOV.jpg")!),
            ImageModel(url: URL(string: "https://s29843.pcdn.co/blog/wp-content/uploads/sites/2/2016/11/what-is-high-res-768x570.jpg")!),
            ImageModel(url: URL(string: "https://www.procyclinguk.com/wp-content/uploads/2015/04/2015PR.jpg")!),
            ImageModel(url: URL(string: "https://vastphotos.com/files/uploads/photos/10430/ocean-landscape-photo-print-xl.jpg")!)
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
