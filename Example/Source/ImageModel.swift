//
//  ImageModel.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2021 Stefan Herold. All rights reserved.
//

import UIKit
import Source

struct ImageModel: ViewModel {
    var image: UIImage

    let id: String = UUID().uuidString
    var cellType: (Configurable & Reusable).Type = ImageCell.self
    var separatorInsets: NSDirectionalEdgeInsets = .zero
    let accessory: UITableViewCell.AccessoryType = .none
    let didTap: IndexPathClosure? = nil
    let didDelete: IndexPathClosure? = nil
}
