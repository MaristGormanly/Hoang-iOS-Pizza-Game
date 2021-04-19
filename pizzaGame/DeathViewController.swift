//
//  DeathViewController.swift
//  pizzaGame
//
//  Created by Timothy Hoang on 3/30/21.
//  Copyright © 2021 Timothy Hoang. All rights reserved.
//

import AVFoundation
import UIKit

class DeathViewController: UIViewController {
    
    var scoreInt = 0
    var playerName = ""

    @IBOutlet weak var scoreLabel: UILabel!
    
    //our music player
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreLabel.text = String(scoreInt)
        
    }
    
    //go to game screen
    @IBAction func startGame() {
        
        //set up player and play
        let clickUrlString = Bundle.main.path(forResource: "button_click", ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let clickUrlString = clickUrlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: clickUrlString))
            
            guard let player = player else {
                return
            }
            
            player.play()
        }
        catch {
            
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        vc.playerName = playerName
        present(vc, animated: true)
        
    }
    
    //go to hi-score screen
    @IBAction func showHiScores() {
        
        //set up player and play
        let clickUrlString = Bundle.main.path(forResource: "button_click", ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let clickUrlString = clickUrlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: clickUrlString))
            
            guard let player = player else {
                return
            }
            
            player.play()
        }
        catch {
            
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "scores") as! ScoreViewController
        vc.modalPresentationStyle = .fullScreen
        //send the score and player information
        vc.scoreInt = scoreInt
        vc.playerName = playerName
        present(vc, animated: true)
        
    }
    
    //go to the main menu
    @IBAction func mainMenu() {
        
        //set up player and play
        let clickUrlString = Bundle.main.path(forResource: "button_click", ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let clickUrlString = clickUrlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: clickUrlString))
            
            guard let player = player else {
                return
            }
            
            player.play()
        }
        catch {
            
        }
        
        let vc = storyboard?.instantiateViewController(identifier: "main") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}
