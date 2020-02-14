//
//  Section.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import Foundation

public protocol Section {
    var models: [ViewModel] { get set }
    var headerTitle: String? { get }
    var footerTitle: String? { get }
}

public extension Section {
    var count: Int { models.count }

    subscript(index: Int) -> ViewModel { models[index] }

    mutating func remove(at index: Int) {
        guard index < models.count else { return }
        models.remove(at: index)
    }
}

public struct DefaultSection: Section {
    public var models: [ViewModel]
    public let headerTitle: String?
    public let footerTitle: String?

    public init(models: [ViewModel], headerTitle: String? = nil, footerTitle: String? = nil) {
        self.models = models
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
}
