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
    static var reuseIdentifier: String {get}
}

extension Reusable {
    public static var reuseIdentifier: String {
        return "\(Self.self)"
    }
}
