//
//  BlindState.swift
//  XO-game
//
//  Created by user on 12.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class BlindState: GameState {
    
    var isCompleted: Bool = false
    var invoker = BlindGameInvoker()
    var player: Player
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    
    
    private let markViewPrototype: MarkView
    
    init(player: Player, markViewPrototype: MarkView, gameViewController: GameViewController, gameBoard: Gameboard, gameboardView: GameboardView) {
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameboard = gameBoard
        self.gameboardView = gameboardView
        self.player = player
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
            
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
            
        }
        
        self.gameViewController?.winnerLabel.isHidden = true
        self.gameViewController?.drawMarkOnBlindMode.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        if BlindGameInvoker.shared.commands.count == 5 {
            player = .second
        }
        BlindGameInvoker.shared.commands.append(BlindModeCommand(player: player,
                                                                 position: position,
                                                                 gameboard: gameboard!,
                                                                 gameboardView: gameboardView!))
        if BlindGameInvoker.shared.commands.count == 10 {
            isCompleted = true
        }
    }
    
}
