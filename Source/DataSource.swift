//
//  DataSource.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2024 Stefan Herold. All rights reserved.
//

import UIKit

public typealias DataSourceDidChangedClosure = (_ dataSource: DataSource) -> Void

public enum ModelError<T>: Swift.Error {
    case invalidModel(T?)
}

public final class DataSource: NSObject {

    public var collection: ModelCollection = ModelCollection() {
        didSet {
            dataSourceDidChangedClosure?(self)
        }
    }

    public var useSectionIndexTitles = true {
        didSet {
            dataSourceDidChangedClosure?(self)
        }
    }

    public var dataSourceDidChangedClosure: DataSourceDidChangedClosure?
    public let numberOfLastSeparatorsToHide: Int
    public private (set) var cellHeightCache: [IndexPath: CGFloat] = [:]

    // MARK: - Lifecycle

    public convenience override init() {
        self.init(numberOfLastSeparatorsToHide: 1)
    }

    public init(numberOfLastSeparatorsToHide: Int) {
        self.numberOfLastSeparatorsToHide = numberOfLastSeparatorsToHide
    }

    public func registerCellsAndSupplementaryViews(for table: UITableView) {

        collection.allModels.forEach {
            table.register($0.cellType, forCellReuseIdentifier: $0.cellType.reuseIdentifier)
        }

        collection.sections.compactMap(\.headerModel).forEach { (model) in
            table.register(model.viewType, forHeaderFooterViewReuseIdentifier: model.viewType.reuseIdentifier)
        }

        collection.sections.compactMap(\.footerModel).forEach { (model) in
            table.register(model.viewType, forHeaderFooterViewReuseIdentifier: model.viewType.reuseIdentifier)
        }
    }
}

extension DataSource: UITableViewDataSource {

    public func numberOfSections(in tableView: UITableView) -> Int {
        collection.sectionCount
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        collection.rowsForSection(section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let model = collection[indexPath]
        let cell = tableView.dequeueReusableCell(withIdentifier: model.cellType.reuseIdentifier, for: indexPath)
        cell.selectionStyle = model.didTap == nil ? .none : .default
        cell.accessoryType = model.accessory

        do {
            try (cell as? Configurable)?.configure(with: model)

            if let height = (cell as? HeightConfigurable)?.height {
                DispatchQueue.main.async {
                    var clampedHeight = height

                    if height != UITableView.automaticDimension {
                        clampedHeight = max(height, 0)
                    }

                    if self.cellHeightCache[indexPath] != clampedHeight {
                        self.cellHeightCache[indexPath] = clampedHeight
                        tableView.reloadData()
                    }
                }
            }

        } catch {
            preconditionFailure("\(error)")
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        guard collection.isInBounds(indexPath) else {
            return false
        }
        return collection[indexPath].didDelete != nil
    }

    // MARK: - Section Index Titles

    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        useSectionIndexTitles ? collection.sectionsWithIndexTitles.compactMap { $0.indexTitle } : nil
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        collection.sectionsWithIndexTitles[index].section
    }
}
