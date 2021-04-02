//
//  ScoreViewController.swift
//  pizzaGame
//
//  Created by Timothy Hoang on 3/28/21.
//  Copyright © 2021 Timothy Hoang. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {
    
    var scoreInt = 0
    var hiScores = [Int](repeating: 0, count: 10)
    var temp = 0
    var i = 0
    var playerName = ""
    var names = [String](repeating: "Placeholder", count: 10)
    var tempName = ""
    
    @IBOutlet weak var name1Label: UILabel!
    @IBOutlet weak var score1Label: UILabel!
    
    @IBOutlet weak var name2Label: UILabel!
    @IBOutlet weak var score2Label: UILabel!
    
    @IBOutlet weak var name3Label: UILabel!
    @IBOutlet weak var score3Label: UILabel!
    
    @IBOutlet weak var name4Label: UILabel!
    @IBOutlet weak var score4Label: UILabel!
    
    @IBOutlet weak var name5Label: UILabel!
    @IBOutlet weak var score5Label: UILabel!
    
    @IBOutlet weak var name6Label: UILabel!
    @IBOutlet weak var score6Label: UILabel!
    
    @IBOutlet weak var name7Label: UILabel!
    @IBOutlet weak var score7Label: UILabel!
    
    @IBOutlet weak var name8Label: UILabel!
    @IBOutlet weak var score8Label: UILabel!
    
    @IBOutlet weak var name9Label: UILabel!
    @IBOutlet weak var score9Label: UILabel!
    
    @IBOutlet weak var name10Label: UILabel!
    @IBOutlet weak var score10Label: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var hiScoresDefault = UserDefaults.standard
        if(hiScoresDefault.value(forKey: "hiScores") != nil) {
            hiScores = hiScoresDefault.value(forKey: "hiScores") as! [Int]
        }
        
        var namesDefault = UserDefaults.standard
        if(namesDefault.value(forKey: "names") != nil) {
            names = namesDefault.value(forKey: "names") as! [String]
        }
        
        while i < 9 {
            
            if(scoreInt > hiScores[i]) {
                temp = hiScores[i]
                tempName = names[i]
                hiScores[i] = scoreInt
                names[i] = playerName
                scoreInt = temp
                playerName = tempName
            }
            i += 1
        }
        
        i = 0;
        
        hiScoresDefault.setValue(hiScores, forKey: "hiScores")
        hiScoresDefault.synchronize()
        
        namesDefault.setValue(names, forKey: "names")
        namesDefault.synchronize()
        
        score1Label.text = String(hiScores[0])
        score2Label.text = String(hiScores[1])
        score3Label.text = String(hiScores[2])
        score4Label.text = String(hiScores[3])
        score5Label.text = String(hiScores[4])
        score6Label.text = String(hiScores[5])
        score7Label.text = String(hiScores[6])
        score8Label.text = String(hiScores[7])
        score9Label.text = String(hiScores[8])
        score10Label.text = String(hiScores[9])
        
        name1Label.text = names[0]
        name2Label.text = names[1]
        name3Label.text = names[2]
        name4Label.text = names[3]
        name5Label.text = names[4]
        name6Label.text = names[5]
        name7Label.text = names[6]
        name8Label.text = names[7]
        name9Label.text = names[8]
        name10Label.text = names[9]
        
    }
    
    //go to main menu
    @IBAction func mainMenu() {
        let vc = storyboard?.instantiateViewController(identifier: "main") as! ViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }

}
