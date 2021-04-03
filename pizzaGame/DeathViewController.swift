//
//  DeathViewController.swift
//  pizzaGame
//
//  Created by Timothy Hoang on 3/30/21.
//  Copyright © 2021 Timothy Hoang. All rights reserved.
//

import UIKit

class DeathViewController: UIViewController {
    
    var scoreInt = 0
    var playerName = ""

    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = String(scoreInt)
        
    }
    
    //go to game screen
    @IBAction func startGame() {
        
        let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    
    //go to hi-score screen
    @IBAction func showHiScores() {
        
        let vc = storyboard?.instantiateViewController(identifier: "scores") as! ScoreViewController
        vc.modalPresentationStyle = .fullScreen
        //send the score and player information
        vc.scoreInt = scoreInt
        vc.playerName = playerName
        present(vc, animated: true)
        
    }
    
    //go to the main menu
    @IBAction func mainMenu() {
        let vc = storyboard?.instantiateViewController(identifier: "main") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}
