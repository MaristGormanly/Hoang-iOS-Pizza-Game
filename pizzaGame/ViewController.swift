//
//  ViewController.swift
//  pizzaGame
//
//  Created by Timothy Hoang on 3/27/21.
//  Copyright © 2021 Timothy Hoang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var playerName = ""

    @IBOutlet weak var usernameText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //game screen
    @IBAction func startGame() {
        let vc = storyboard?.instantiateViewController(identifier: "game") as! GameViewController
        vc.modalPresentationStyle = .fullScreen
        vc.playerName = usernameText.text!
        present(vc, animated: true)
    }
    
    //hi-score screen
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

