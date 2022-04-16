//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by user on 10.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

//MARK: - Invoker

internal final class LoggerInvoker {
    
    
    //MARK: - Singleton
   internal static let shared = LoggerInvoker()

    //MARK: - Private properties
    
    private let logger = LoggerReceiver()
    
    private let batchSize = 8
    
    private var commands: [LogCommand] = []
    
    //MARK: - Internal
    
    internal func addLogCommand(_ command: LogCommand) {
        self.commands.append(command)
        self.executeCommandsIfNeeded()
    }
    
    //MARK:- Private
    
    private func executeCommandsIfNeeded() {
        print (commands.count)
        guard self.commands.count >= batchSize else {
            return
        }
        
        self.commands.forEach { self.logger.writeMessageToLog($0.logMessage)
        }
        self.commands = []
    }
}

