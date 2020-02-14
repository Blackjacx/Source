//
//  ImageModel.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit
import Source

struct ImageModel: ViewModel {
    var url: URL

    let id: String = UUID().uuidString
    var cellType: (Configurable & Reusable).Type = ImageCell.self
    var separatorInsets: NSDirectionalEdgeInsets = .zero
    let didTap: IndexPathClosure? = nil
    let didDelete: IndexPathClosure? = nil
}
