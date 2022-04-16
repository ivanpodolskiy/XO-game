//
//  BlindModeInvoker.swift
//  XO-game
//
//  Created by user on 12.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation


public func invoker() {
    BlindGameInvoker.shared.work()
}

internal class BlindGameInvoker {
    //MARK: - Singleton
    internal static let shared = BlindGameInvoker()
    
    
    var commands: [BlindModeCommand] = []
    
    func work() {
        commands[0].execute()
        commands.removeFirst()
    }
}
