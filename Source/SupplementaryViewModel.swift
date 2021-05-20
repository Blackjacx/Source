//
//  SupplementaryViewModel.swift
//  Source
//
//  Created by Stefan Herold on 10.08.20.
//  Copyright © 2021 Stefan Herold. All rights reserved.
//

import UIKit

public protocol SupplementaryViewModel {

    var title: String { get }
    var viewType: (ConfigurableSupplementaryView & Reusable).Type { get }
}

public struct DefaultSupplementaryViewModel: SupplementaryViewModel {

    public var title: String
    public var insets: NSDirectionalEdgeInsets
    public var bgColor: UIColor?
    public var textAttributes: [NSAttributedString.Key: Any]?

    public let viewType: (ConfigurableSupplementaryView & Reusable).Type = DefaultSupplementaryView.self

    public init(title: String,
                insets: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0),
                bgColor: UIColor? = nil,
                textAttributes: [NSAttributedString.Key: Any]? = nil) {

        self.title = title
        self.insets = insets
        self.textAttributes = textAttributes

        if #available(iOS 13.0, *) {
            self.bgColor = bgColor ?? UIColor.systemGray5
        } else {
            self.bgColor = bgColor ?? UIColor.lightGray
        }
    }
}

class DefaultSupplementaryView: UITableViewHeaderFooterView, ConfigurableSupplementaryView, Reusable {

    private let titleLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func setup() {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView = backgroundView

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.adjustsFontForContentSizeCategory = true
        contentView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }

    public func configure(with model: SupplementaryViewModel?) throws {

        guard let viewModel = model as? DefaultSupplementaryViewModel else {
            throw ModelError.invalidModel(model)
        }

        contentView.directionalLayoutMargins = viewModel.insets

        backgroundView?.backgroundColor = viewModel.bgColor
        titleLabel.attributedText = NSAttributedString(string: viewModel.title, attributes: viewModel.textAttributes)
    }
}
