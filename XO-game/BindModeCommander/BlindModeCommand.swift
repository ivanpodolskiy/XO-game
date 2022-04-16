//
//  BlindModeCommand.swift
//  XO-game
//
//  Created by user on 12.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

protocol Command  {
    func execute()
    var player: Player { get }
    var postion: GameboardPosition {get}
}

final class BlindModeCommand: Command  {
    weak var gameboard: Gameboard?
    weak var gameboardView: GameboardView?
    var player: Player
    var postion: GameboardPosition
    
    init(player: Player, position: GameboardPosition, gameboard: Gameboard, gameboardView: GameboardView) {
        self.gameboard = gameboard
        self.gameboardView = gameboardView
        self.player = player
        self.postion = position
    }
    
    func execute() {
        if gameboardView?.canPlaceMarkView(at: postion) != true  {
            gameboardView?.removeMarkView(at: postion)
        }
        gameboard?.setPlayer(player, at: postion)
        gameboardView?.placeMarkView(player.markViewPrototype.copy(), at: postion)
    }
}
