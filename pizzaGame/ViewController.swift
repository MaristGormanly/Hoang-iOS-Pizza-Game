//
//  ViewController.swift
//  pizzaGame
//
//  Created by Timothy Hoang on 3/27/21.
//  Copyright © 2021 Timothy Hoang. All rights reserved.
//

import AVFoundation
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var animatedPizza: UIImageView!
    
    //our music player
    var player: AVAudioPlayer?
    
    var playerName = ""

    @IBOutlet weak var usernameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load our aniamted gif using the framework in "Swift+Gif.swift"
        animatedPizza.loadGif(name: "pizzaSliceAnimated")
    }

    //go to the game screen
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
        //send the text in the username text field
        vc.playerName = usernameText.text!
        present(vc, animated: true)
    }
    
    //go to the hi-score screen
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
        present(vc, animated: true)
    }
    
    //exit app
    @IBAction func exitApp() {
        
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
        
        exit(-1)
    }

}

