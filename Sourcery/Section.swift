//
//  Section.swift
//  Sourcery
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import Foundation

protocol Section {

    var sortOrder: Int { get }
    var items: [Item] { get set }
    var headerTitle: String? { get }
    var footerTitle: String? { get }
}

extension Section {

    var count: Int { return items.count }

    subscript(index: Int) -> Item {
        get {
            return items[index]
        }

        set(newValue) {
            items[index] = newValue
        }
    }
}
