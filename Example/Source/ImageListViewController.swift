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

    let urls = [
        URL(string: "https://mcdn.wallpapersafari.com/medium/47/47/8b2sOV.jpg")!,
        URL(string: "https://s29843.pcdn.co/blog/wp-content/uploads/sites/2/2016/11/what-is-high-res-768x570.jpg")!,
        URL(string: "https://www.procyclinguk.com/wp-content/uploads/2015/04/2015PR.jpg")!,
        URL(string: "https://vastphotos.com/files/uploads/photos/10430/ocean-landscape-photo-print-xl.jpg")!
    ]

    override func viewDidLoad() {

        super.viewDidLoad()

        table.dataSource = dataSource
        table.delegate = self

        table.addMaximizedTo(view)

        let placeholders = Array(repeating: UIImage(named: "placeholder")!, count: urls.count)
        setupDataSource(images: placeholders, fetchData: true)
    }

    private func setupDataSource(images: [UIImage], fetchData: Bool) {

        dataSource.dataSourceDidChangedClosure = { [weak self] (source) in
            guard let self = self else { return }
            source.registerCells(for: self.table)
            self.table.reloadData()
        }

        let models = images.map { ImageModel(image: $0) }

        let sections = [
            DefaultSection(models: models, headerTitle: nil, footerTitle: nil)
        ]
        dataSource.collection = ModelCollection(sections: sections)

        if fetchData {
            DownloadManager.shared.fetch(urls) { [weak self] (result) in
                let images = result.compactMap { try? $0.get().image }
                self?.setupDataSource(images: images, fetchData: false)
            }
        }
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
