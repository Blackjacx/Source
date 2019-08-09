//
//  MyConfigurableCell.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import UIKit
import Source

class MyConfigurableCell: UITableViewCell, Reusable {
    let titleLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)

        setupLayoutConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayoutConstraints() {

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


extension MyConfigurableCell: Configurable {

    func configure(with model: ViewModel?) throws {
        guard let myModel = model as? MyModel else {
            throw Source.Error.invalidModel(model)
        }
        titleLabel.text = myModel.title
    }
}
