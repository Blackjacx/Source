//
//  Section.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import Foundation

public protocol Section {

    var items: [Item] { get set }
    var headerTitle: String? { get }
    var footerTitle: String? { get }
    var count: Int { get }
}

extension Section {

    public var count: Int { return items.count }

    public subscript(index: Int) -> Item {
        return items[index]
    }
}
