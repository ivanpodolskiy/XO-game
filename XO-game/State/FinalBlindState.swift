//
//  FinalBlindState.swift
//  XO-game
//
//  Created by user on 15.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class FinalBlindState: GameState {
    var isCompleted: Bool = false
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    init(gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {

        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    
    func begin() {
        gameViewController?.counter.text = "Нажмите на кнопку"
        gameViewController?.drawMarkOnBlindMode.isHidden = false
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) { }
}
