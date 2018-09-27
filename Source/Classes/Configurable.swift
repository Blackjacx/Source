//
//  Configurable.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit

public protocol Configurable: class {

    func configureWithItem(_ item: Item?) throws
}
