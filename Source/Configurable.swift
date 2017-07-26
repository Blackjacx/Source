//
//  Configurable.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import Foundation

public protocol Configurable {

    func configureWithItem(_ item: Item) throws
}
