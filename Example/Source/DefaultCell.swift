//
//  MyConfigurableCell.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit
import Source

class DefaultCell: UITableViewCell, Reusable {
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        setupAutolayout()
    }

    @available(*, unavailable, message: "init(coder:) has not been implemented")
    required init?(coder aDecoder: NSCoder) {
        preconditionFailure("init(coder:) has not been implemented")
    }

    private func setupAutolayout() {

        let raster: CGFloat = 11

        let constraints: [NSLayoutConstraint] = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: raster),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -raster),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: raster),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -raster)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension DefaultCell: Configurable {

    func configure(with model: ViewModel?) throws {
        guard let myModel = model as? CustomModel else {
            throw Source.Error.invalidModel(model)
        }
        titleLabel.text = myModel.title
    }
}
