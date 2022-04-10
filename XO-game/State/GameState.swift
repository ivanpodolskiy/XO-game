//
//  GameState.swift
//  XO-game
//
//  Created by user on 09.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol GameState {
    var isCompleted: Bool {get }
    
    func begin()
    func addMark(at position: GameboardPosition)
}
