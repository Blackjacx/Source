//
//  NSDirectionalEdgeInsets+Extensions.swift
//  Source
//
//  Created by Stefan Herold on 07.08.19.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import UIKit

public extension NSDirectionalEdgeInsets {

    /// Converts the NSDirectionalEdgeInsets back to UIEdgeInsets and
    /// automatically switches leading and trailing if the layout direction is
    /// RTL.
    var edgeInsets: UIEdgeInsets {
        switch UIApplication.shared.userInterfaceLayoutDirection {
        case .leftToRight:
            return UIEdgeInsets(top: top, left: leading, bottom: bottom, right: trailing)
        case .rightToLeft:
            return UIEdgeInsets(top: top, left: trailing, bottom: bottom, right: leading)
        @unknown default: return .zero
        }
    }
}
