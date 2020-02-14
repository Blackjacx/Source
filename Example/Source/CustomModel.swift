//
//  MyModel.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2020 Stefan Herold. All rights reserved.
//

import UIKit
import Source

struct CustomModel: ViewModel {
    let id: String = UUID().uuidString
    var title: String
    var cellType: (Configurable & Reusable).Type = DefaultCell.self
    var separatorInsets: NSDirectionalEdgeInsets = .zero
    var didTap: IndexPathClosure?
    var didDelete: IndexPathClosure?
}

extension CustomModel {

    init(title: String, didTap: IndexPathClosure? = nil, didDelete: IndexPathClosure? = nil) {
        self.title = title
        self.didTap = didTap
        self.didDelete = didDelete
    }
}
