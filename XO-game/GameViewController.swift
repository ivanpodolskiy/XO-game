//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    var game: Game?
    var gameMode: GameMode = .computerMode
    var text: String?

    
    //MARK: - outletls
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    @IBOutlet var counter: UILabel!
    @IBOutlet weak var drawMarkOnBlindMode: UIButton!
    @IBOutlet weak var gameModeLabel: UILabel!
    
    
    //MARK: - Private Properties
    private let gameboard = Gameboard()
    
    
    //MARK: - Lifecycel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.game = Game(gameMode: gameMode, gameViewController: self, gameboardView: gameboardView)
        self.gameModeLabel.text = text
        game?.gameMainMethod()
    }
    
    
    //    func goTo
    //MARK: - Actions
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        game?.restartGame()
    }
    
    @IBAction func actionDrawMarkOnBlindMode(_ sender: UIButton) {
        game?.blindeMode(sender: drawMarkOnBlindMode)
    }
}

