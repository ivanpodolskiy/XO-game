//
//  GmeEndedState.swift
//  XO-game
//
//  Created by user on 10.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class GameEndedState: GameState {
    
    //MARK: - Properties
    var isCompleted: Bool = false
    
    let winner: Player?
    private(set) weak var gameViewController: GameViewController?
    
    //MARK: - Construction
    
    init(winner: Player, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    //MARK: - Functions
    func begin() {
        Log(.gameFinished(winner: self.winner))
        gameViewController?.winnerLabel.isHidden = false
        if let winner = winner {
            gameViewController?.winnerLabel.text = winnerName(from: winner) + " win"
        } else {
            gameViewController?.winnerLabel.text = "No winner"
        }
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) { }
    
    //MARK: - Private Functions
    private func winnerName(from winner: Player) -> String {
        switch winner {
        case .first:
            return "1st player"
        case .second:
            return "2nd player"
        }
    }
}
