//
//  Game.swift
//  XO-game
//
//  Created by user on 15.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import Foundation
import UIKit
class Game {
    
    // MARK: - Properties
    
    private lazy var referee = Referee(gameboard: gameboard)
    private  var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    private  var gameMode: GameMode?
    private var counter: Int = 10
    private  var gameboard =  Gameboard()
    private var gameboardView: GameboardView?
    private var player: Player = .first
    private var gameViewController: GameViewController?
    
    
    
    init(gameMode: GameMode, gameViewController: GameViewController, gameboardView: GameboardView) {
        self.gameboardView = gameboardView
        self.gameMode = gameMode
        self.gameViewController = gameViewController
    }
    
    
    // MARK: - public
    
    func blindeMode(sender: UIButton){
        guard let viewController = gameViewController else {
            return
        }
        guard BlindGameInvoker.shared.commands.count != 0 else {
            return
        }
        counter += 1
        invoker()
        gameViewController?.counter.text = "\(counter) ход"
        
        if let winner = referee.determineWinner() {
            currentState = GameEndedState(winner: winner, gameViewController: viewController)
            return
        }
    }
    
    func restartGame() {
        Log(.restartGame)
        gameboardView?.clear()
        BlindGameInvoker.shared.commands = []
        player = .first
        gameboard.clear()
        gameMainMethod()
    }
    
    func gameMainMethod() {
        startGame()
        gameboardView?.onSelectPosition = { [weak self] position in
            guard let self = self else { return }
            self.play(position: position)
        }
    }
    
    
    // MARK: - Private
    private func startGame() {
        switch gameMode {
        case .multiplayMode:
            goToFirstState()
        case .computerMode:
            goToFirstState()
        case .blindMode:
            goToBlindState()
            currentState.begin()
        case .none:
            break
        }
    }
    
    
    private func play(position: GameboardPosition) {
        switch self.gameMode {
        case .multiplayMode:
            self.currentState.addMark(at: position)
    
            if self.currentState.isCompleted {
                self.goToNextState()
            }
            
        case .computerMode:
            self.goToFirstState()
            self.currentState.addMark(at: position)
            if self.currentState.isCompleted  {
                self.goToCompState()
                self.currentState.addMark(at: GameboardPosition(column: Int.random(in: 0..<3), row: Int.random(in: 0..<3)))
                self.goToFirstState()
            }
        case .blindMode:
            self.counter -= 1
            self.goToBlindState()
            self.currentState.addMark(at: position)
            
            if currentState.isCompleted == true {
                self.goToFinalBlindState()
                currentState.begin()
            }
        case .none:
            break
        }
    }
    
    
    
    //MARK: - State
    
    private func goToFirstState(){
        guard let viewController =  gameViewController, let gameboardView = gameboardView else {
            return
        }
        if let winner = referee.determineWinner() {
            currentState = GameEndedState(winner: winner, gameViewController: viewController)
            return
        }
        currentState = PlayerInputState(player: player,
                                        markViewPrototype: player.markViewPrototype,
                                        gameViewController: viewController,
                                        gameboard: gameboard,
                                        gameboardView: gameboardView)
    }
    
    private func goToNextState(){
        guard let viewController =  gameViewController, let gameboardView = gameboardView else {
            return
        }
        if let winner = referee.determineWinner() {
            currentState = GameEndedState(winner: winner, gameViewController:viewController)
            return
        }
        if let playerInputState = currentState as? PlayerInputState {
            self.player = playerInputState.player.next
            currentState = PlayerInputState(player: player,
                                            markViewPrototype: player.markViewPrototype,
                                            gameViewController: viewController,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView)
        }
    }
    
    private func goToCompState() {
        guard let viewController =  gameViewController, let gameboardView = gameboardView else {
            return
        }
        if let winner = referee.determineWinner() {
            currentState = GameEndedState(winner: winner, gameViewController: viewController)
            return
        }
        if let compState = currentState as? PlayerInputState {
            let player = compState.player.next
            currentState = CompureState(player: player,
                                        markViewPrototype: player.markViewPrototype,
                                        gameViewController: viewController,
                                        gameboard: gameboard,
                                        gameboardView: gameboardView)
        }
    }
    
    
    private  func goToBlindState() {
        guard let viewController =  gameViewController, let gameboardView = gameboardView else {
            return
        }
        gameViewController?.counter.text = "Осталось: \(counter)"
        
        if counter == 4  {
            self.player =  player.next
        }
        
        currentState = BlindState(player: player,
                                  markViewPrototype: player.markViewPrototype,
                                  gameViewController: viewController,
                                  gameBoard: gameboard,
                                  gameboardView: gameboardView)
    }
    
    private func goToFinalBlindState() {
        guard let viewController =  gameViewController, let gameboardView = gameboardView else {
            return
        }
        currentState = FinalBlindState(gameViewController: viewController, gameboard: gameboard, gameboardView: gameboardView)
    }
}

