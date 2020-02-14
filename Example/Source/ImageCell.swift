//
//  ImageCell.swift
//  Source_Example
//
//  Created by Stefan Herold on 14.02.20.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit
import Source

final class ImageCell: UITableViewCell {

    static let reuseID = "img_cell"
    static let paddingV: CGFloat = 25
    static let paddingH: CGFloat = 50

    private lazy var imgView: UIImageView! = UIImageView()

    // MARK: - Initalization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {

        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemBackground
        setupImgView()
        setupAutoLayout()
    }

    required init?(coder: NSCoder) {

        super.init(coder: coder)
        backgroundColor = .systemBackground
        setupImgView()
        setupAutoLayout()
    }

    private func setupImgView() {

        imgView.backgroundColor = .systemBackground
        imgView.contentMode = .scaleAspectFit

        if imgView.superview == nil {
            imgView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(imgView)
        }
    }

    private func setupAutoLayout() {

        let constraints: [NSLayoutConstraint] = [
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.paddingH),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Self.paddingH),
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.paddingV),
            imgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Self.paddingV)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension ImageCell: Configurable, Reusable {

    func configure(with model: ViewModel?, didCalculateHeight: @escaping DidCalculateHeightClosure) throws {

        guard let myModel = model as? ImageModel else {
            throw Source.Error.invalidModel(model)
        }

        imgView.setImage(from: myModel.url, didSetImage: { [weak self] img in
            guard let self = self, let img = img else {
                didCalculateHeight(Self.paddingV * 2)
                return
            }
            let imgAspect = img.size.width / img.size.height
            let imgViewWidth = self.contentView.frame.width - 2 * Self.paddingH
            let imgViewHeight = imgViewWidth / imgAspect

            didCalculateHeight(imgViewHeight + 2 * Self.paddingV)
        })
    }
}
