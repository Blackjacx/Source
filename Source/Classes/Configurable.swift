//
//  Configurable.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2018 CodingCobra. All rights reserved.
//

import Foundation

public protocol Configurable: class {
    func configure(with model: ViewModel?) throws
}
