//
//  Reusable.swift
//  Source
//
//  Created by Stefan Herold on 26.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import Foundation

public protocol Reusable {

    static var reuseIdentifier: String {get}
}

extension Reusable {

    public static var reuseIdentifier: String {
        return "\(Self.self)"
    }
}
