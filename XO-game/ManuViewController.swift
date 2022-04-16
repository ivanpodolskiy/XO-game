//
//  ManuViewController.swift
//  XO-game
//
//  Created by user on 10.04.2022.
//  Copyright © 2022 plasmon. All rights reserved.
//

import UIKit

class ManuViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "multiplayerMode":
            guard let game = segue.destination as? GameViewController else {
                return
            }
            game.gameMode = .multiplayMode
            game.text = "Режим игры: Два игрока"
            
        case "computerMode":
            guard let game = segue.destination as? GameViewController else {
                return
            }
            game.gameMode = .computerMode
            game.text = "Игра против компьютера"
            
        
            
        case "blindMode" :
            guard let game = segue.destination as? GameViewController else {
                return
            }
            game.gameMode = .blindMode
            game.text = "Слепой режим"
            
        default:
            break
        }
    }
}
