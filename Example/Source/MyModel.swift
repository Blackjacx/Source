//
//  MyModel.swift
//  Source
//
//  Created by Stefan Herold on 24.07.17.
//  Copyright © 2019 CodingCobra. All rights reserved.
//

import UIKit
import Source

struct MyModel: ViewModel {
    let id: String = UUID().uuidString
    var title: String
    var cellType: (Configurable & Reusable).Type = MyConfigurableCell.self
    var separatorInsets: NSDirectionalEdgeInsets = .zero
    var didTap: DidTapClosure?
    var didDelete: DidDeleteClosure?
}

extension MyModel {

    init(title: String, didTap: DidTapClosure? = nil, didDelete: DidDeleteClosure? = nil) {
        self.title = title
        self.didTap = didTap
        self.didDelete = didDelete
    }
}
