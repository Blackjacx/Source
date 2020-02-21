//
//  Extensions.swift
//  Source
//
//  Created by Stefan Herold on 26.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit

// MARK: - Auto-Layout Friendly View Adding

public extension UIView {

    func addMaximizedTo(_ parent: UIView, margins: UIEdgeInsets = .zero) {
        let constraints: [NSLayoutConstraint] = [
            leftAnchor.constraint(equalTo: parent.leftAnchor, constant: margins.left),
            rightAnchor.constraint(equalTo: parent.rightAnchor, constant: -margins.right),
            topAnchor.constraint(equalTo: parent.topAnchor, constant: margins.top),
            bottomAnchor.constraint(equalTo: parent.bottomAnchor, constant: -margins.bottom)
        ]

        translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
        NSLayoutConstraint.activate(constraints)
    }

    func addTo(_ parent: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        parent.addSubview(self)
    }
}
