//
//  Section.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import Foundation

public protocol Section {
    var models: [ViewModel] { get }
    var headerTitle: String? { get }
    var footerTitle: String? { get }
}

public extension Section {
    var count: Int { return models.count }

    subscript(index: Int) -> ViewModel {
        return models[index]
    }
}

public struct DefaultSection: Section {
    public let models: [ViewModel]
    public let headerTitle: String?
    public let footerTitle: String?

    public init(models: [ViewModel], headerTitle: String? = nil, footerTitle: String? = nil) {
        self.models = models
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
    }
}
