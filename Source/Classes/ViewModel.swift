//
//  ViewModel.swift
//  Source
//
//  Created by Stefan Herold on 23.07.17.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import UIKit

public typealias IndexPathClosure = (_ indexPath: IndexPath) -> Void

public protocol ViewModel {
    var id: String { get }
    var cellType: (Configurable & Reusable).Type { get }
    var separatorInsets: NSDirectionalEdgeInsets { get }
    var didTap: IndexPathClosure? { get }
    var didDelete: IndexPathClosure? { get }
}

public func ==(lhs: ViewModel, rhs: ViewModel) -> Bool {
    return lhs.id == rhs.id
}
