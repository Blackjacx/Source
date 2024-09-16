//
//  Section.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2024 Stefan Herold. All rights reserved.
//

import Foundation

public protocol Section {
    var models: [ViewModel] { get set }
    var sectionIndexTitle: String? { get set }
    var headerModel: SupplementaryViewModel? { get set }
    var footerModel: SupplementaryViewModel? { get set }
}

public extension Section {
    var count: Int { models.count }

    subscript(index: Int) -> ViewModel { models[index] }

    mutating func insert(item: ViewModel, at index: Int) {
        guard index <= models.count else { return } // Use <= since we can insert at models.count without crash
        models.insert(item, at: index)
    }

    mutating func remove(at index: Int) {
        guard index < models.count else { return }
        models.remove(at: index)
    }
}

public struct DefaultSection: Section {
    public var models: [ViewModel]
    public var sectionIndexTitle: String?
    public var headerModel: SupplementaryViewModel?
    public var footerModel: SupplementaryViewModel?

    public init(models: [ViewModel],
                sectionIndexTitle: String? = nil,
                headerModel: SupplementaryViewModel? = nil,
                footerModel: SupplementaryViewModel? = nil) {

        self.models = models
        self.sectionIndexTitle = sectionIndexTitle

        if let headerModel = headerModel { self.headerModel = headerModel }
        if let footerModel = footerModel { self.footerModel = footerModel }
    }
}
