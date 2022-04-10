//
//  Copying.swift
//  XO-game
//
//  Created by user on 10.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol Copying{
    init(_ porototype: Self)
}

extension Copying{
    func copy() -> Self {
        return type(of: self).init(self)
    }
}


