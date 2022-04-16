//
//  ComputerState.swift
//  XO-game
//
//  Created by user on 10.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation

class CompureState: GameState {
    
    var isCompleted: Bool = false
    
    let player: Player
    
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    private let markViewPrototype: MarkView
    
    init(player: Player ,markViewPrototype: MarkView, gameViewController: GameViewController, gameboard: Gameboard, gameboardView: GameboardView) {
        self.player = player
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    
    func begin() {
    }
    
    func addMark(at position: GameboardPosition) {
        guard gameboardView?.examinationForCompletion() == true else {
            return
        }
        
        var i: Int = 0
        if gameboardView?.canPlaceMarkView(at: position) == true {
            gameboard?.setPlayer(player, at: position)
            gameboardView?.placeMarkView(markViewPrototype, at: position)
        } else {
            var Newpostion: GameboardPosition?
            repeat {
                print (i)
                i += 1
                Newpostion = GameboardPosition(column: Int.random(in: 0..<3), row: Int.random(in: 0..<3))
            } while gameboardView?.canPlaceMarkView(at: Newpostion!) == false
            gameboard?.setPlayer(player, at: Newpostion!)
            gameboardView?.placeMarkView(markViewPrototype, at: Newpostion!)
        }
        isCompleted = true
    }
}
