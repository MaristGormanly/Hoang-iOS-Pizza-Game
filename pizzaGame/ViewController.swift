//
//  ViewController.swift
//  pizzaGame
//
//  Created by Timothy Hoang on 3/27/21.
//  Copyright © 2021 Timothy Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var animatedPizza: UIImageView!
    
    var playerName = ""

    @IBOutlet weak var usernameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //load our aniamted gif using the framework in "Swift+Gif.swift"
        animatedPizza.loadGif(name: "pizzaSliceAnimated")
    }

    //go to the game screen
    @IBAction func startGame() {
        let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        //send the text in the username text field
        vc.playerName = usernameText.text!
        present(vc, animated: true)
    }
    
    //go to the hi-score screen
    @IBAction func showHiScores() {
        let vc = storyboard?.instantiateViewController(identifier: "scores") as! ScoreViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    //exit app
    @IBAction func exitApp() {
        exit(-1)
    }

}

