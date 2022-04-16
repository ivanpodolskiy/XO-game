//
//  LogCommand.swift
//  XO-game
//
//  Created by user on 10.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation


//MARK: - Command
final class LogCommand {
    
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    var logMessage: String {
        switch action {
        case .playerInput(let player, let postion):
            return "\(player) placed mark at \(postion)"
        case .gameFinished(let winner):
            if let winner = winner {
                return "\(winner) win game"
            } else {
                return "game finished with no winner"
            }
        case .restartGame:
            return "game restarted"
        }
    }
}
