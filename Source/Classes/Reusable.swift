//
//  Reusable.swift
//  Source
//
//  Created by Stefan Herold on 26.07.17.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import Foundation

/// Reusable protocol to seamlessly provide a cellid.
public protocol Reusable {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        "\(Self.self)"
    }
}
