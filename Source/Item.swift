//
//  Item.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2017 CodingCobra. All rights reserved.
//

import UIKit

public typealias CellAction = (_ sender: Any) -> Void

public protocol Item {

    var reusableType: Reusable.Type {get}
    var action: CellAction? {get}
}
