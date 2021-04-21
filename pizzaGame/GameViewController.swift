//
//  GameViewController.swift
//  pizzaGame
//
//  Created by Timothy Hoang on 3/28/21.
//  Copyright © 2021 Timothy Hoang. All rights reserved.
//

import AVFoundation
import UIKit

class GameViewController: UIViewController {
    
    //label to display time remaining
    @IBOutlet var timeLabel: UILabel!
    //label to display current score
    @IBOutlet weak var scoreLabel: UILabel!
    
    //labels to display amounts of toppings needed
    @IBOutlet weak var pepperoniLabel: UILabel!
    @IBOutlet weak var onionLabel: UILabel!
    @IBOutlet weak var pepperLabel: UILabel!
    @IBOutlet weak var oliveLabel: UILabel!
    
    //send pizza button
    @IBOutlet weak var button: UIButton!
    
    //graphics for the toppings to be put on the pizza
    @IBOutlet weak var pepperoniOutlet: UIImageView!
    @IBOutlet weak var onionOutlet: UIImageView!
    @IBOutlet weak var oliveOutlet: UIImageView!
    @IBOutlet weak var pepperOutlet: UIImageView!
    
    //our music player
    var player: AVAudioPlayer?
    var player2: AVAudioPlayer?
    var player3: AVAudioPlayer?
    
    //set initial values
    var scoreInt = 0
    var playerName = ""
    var total = 0
    var pepperoniAmount = 0
    var onionAmount = 0
    var pepperAmount = 0
    var oliveAmount = 0
    var pepperoniOn = 0
    var onionOn = 0
    var pepperOn = 0
    var oliveOn = 0
    var tags = 1
    var gameInt = 10
    var gameTimer = Timer()
    
    //on view load
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up player and play
        let musicUrlString = Bundle.main.path(forResource: "music", ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let musicUrlString = musicUrlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: musicUrlString))
            
            guard let player = player else {
                return
            }
            
            player.play()
        }
        catch {
            
        }
        
        //allows you to modify the views
        self.pepperoniOutlet.translatesAutoresizingMaskIntoConstraints = true
        self.onionOutlet.translatesAutoresizingMaskIntoConstraints = true
        self.oliveOutlet.translatesAutoresizingMaskIntoConstraints = true
        self.pepperOutlet.translatesAutoresizingMaskIntoConstraints = true
        
        //set game timer to 10
        gameInt = 10
        timeLabel.text = String(gameInt)
        
        /*
         Total amount of toppings start at 1 and increase by 1 for every multiple of 3 your score is increased.
         Instead of having an equal change of every topping occurring I decided to have a tier of topping popularity going from pepperoni --> onion --> pepper --> olive. I decided on this because not only does it represent real pizza making orders more, it also may spark strategy for die-hard fans of the game knowing this information.
         */
        total = (scoreInt / 3) + 1
        pepperoniAmount = Int.random(in: 0...total)
        onionAmount = Int.random(in: 0...(total-pepperoniAmount))
        pepperAmount = Int.random(in: 0...(total-(pepperoniAmount+onionAmount)))
        oliveAmount = total - (pepperoniAmount + onionAmount + pepperAmount)
        
        pepperoniLabel.text = String(pepperoniAmount)
        onionLabel.text = String(onionAmount)
        pepperLabel.text = String(pepperAmount)
        oliveLabel.text = String(oliveAmount)
        
        //pan gesture for dragging an image
        var pepperoniPanGesture  = UIPanGestureRecognizer()
        var pepperPanGesture  = UIPanGestureRecognizer()
        var olivePanGesture  = UIPanGestureRecognizer()
        var onionPanGesture  = UIPanGestureRecognizer()
        
        pepperoniPanGesture = UIPanGestureRecognizer(target: self, action: #selector(GameViewController.dragPepperoni(_:)))
        pepperPanGesture = UIPanGestureRecognizer(target: self, action: #selector(GameViewController.dragPepper(_:)))
        onionPanGesture = UIPanGestureRecognizer(target: self, action: #selector(GameViewController.dragOnion(_:)))
        olivePanGesture = UIPanGestureRecognizer(target: self, action: #selector(GameViewController.dragOlive(_:)))
        
        pepperoniOutlet.addGestureRecognizer(pepperoniPanGesture)
        pepperOutlet.addGestureRecognizer(pepperPanGesture)
        oliveOutlet.addGestureRecognizer(olivePanGesture)
        onionOutlet.addGestureRecognizer(onionPanGesture)

        //for every second, start the game timer
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.startGameTimer), userInfo: nil, repeats: true)
        
    }
    
    override func becomeFirstResponder() -> Bool {
        return true
    }
    
    //if the user shakes the device
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if (motion == .motionShake) {
            
            //set up player and play
            let scrapeUrlString = Bundle.main.path(forResource: "scrape", ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let scrapeUrlString = scrapeUrlString else {
                    return
                }
                
                player3 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: scrapeUrlString))
                
                guard let player3 = player3 else {
                    return
                }
                
                player3.play()
            }
            catch {
                
            }
            
            //while there is more than 1 tag
            while tags >= 1 {
                //remove the image (all the placed toppings)
                let viewWithTag = self.view.viewWithTag(tags)
                viewWithTag?.removeFromSuperview()
                tags -= 1
            }
            
            //set the tags to 1
            if(tags == 0) {
                tags = 1
            }
            
            //reset the toppings on the pizza
            pepperoniOn = 0
            onionOn = 0
            pepperOn = 0
            oliveOn = 0
              
        }
        
    }
    
    //when a pepperoni is dragged
    @objc func dragPepperoni(_ sender:UIPanGestureRecognizer){
        
        //move the pepperoni image where it is being dragged
        let translation = sender.translation(in: self.view)
        self.view.bringSubviewToFront(pepperoniOutlet)
        pepperoniOutlet.center = CGPoint(x: pepperoniOutlet.center.x + translation.x, y: pepperoniOutlet.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        //if the pepperoni is released from the drag
        if sender.state == .ended {
            //if it is released on the pizza
            if (pepperoniOutlet.center.x >= 50 && pepperoniOutlet.center.x <= 370 && pepperoniOutlet.center.y >= 280 && pepperoniOutlet.center.y <= 610){
                //place a pepperoni on the spot
                let newPepperoni = "pepperonis.png"
                let pepperoniImage = UIImage(named: newPepperoni)
                let pepperoniNew = UIImageView(image: pepperoniImage)
                pepperoniNew.frame = pepperoniOutlet.frame
                pepperoniNew.contentMode = pepperoniOutlet.contentMode
                //give that pepperoni a tag
                pepperoniNew.tag = tags
                view.addSubview(pepperoniNew)
                
                //repalce the pepperoni that was placed
                pepperoniOutlet.center.x = 135.5
                pepperoniOutlet.center.y = 667.5
                
                //increase amount of pepperonis on by 1 and increase tags by 1
                pepperoniOn += 1;
                tags += 1;
            }
        }
    }
    
    @objc func dragPepper(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        self.view.bringSubviewToFront(pepperOutlet)
        pepperOutlet.center = CGPoint(x: pepperOutlet.center.x + translation.x, y: pepperOutlet.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == .ended {
            if (pepperOutlet.center.x >= 50 && pepperOutlet.center.x <= 370 && pepperOutlet.center.y >= 280 && pepperOutlet.center.y <= 610){
                let newPepper = "peppers.png"
                let pepperImage = UIImage(named: newPepper)
                let pepperNew = UIImageView(image: pepperImage)
                pepperNew.frame = pepperOutlet.frame
                pepperNew.contentMode = pepperOutlet.contentMode
                pepperNew.tag = tags
                view.addSubview(pepperNew)
                
                pepperOutlet.center.x = 280
                pepperOutlet.center.y = 760.5
                
                pepperOn += 1;
                tags += 1;
            }
        }
    }
    
    @objc func dragOnion(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        self.view.bringSubviewToFront(onionOutlet)
        onionOutlet.center = CGPoint(x: onionOutlet.center.x + translation.x, y: onionOutlet.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == .ended {
            if (onionOutlet.center.x >= 50 && onionOutlet.center.x <= 370 && onionOutlet.center.y >= 280 && onionOutlet.center.y <= 610){
                let newOnion = "onions.png"
                let onionImage = UIImage(named: newOnion)
                let onionNew = UIImageView(image: onionImage)
                onionNew.frame = onionOutlet.frame
                onionNew.contentMode = onionOutlet.contentMode
                onionNew.tag = tags
                view.addSubview(onionNew)
                
                onionOutlet.center.x = 281
                onionOutlet.center.y = 673
                
                onionOn += 1;
                tags += 1;
            }
        }
    }
    
    @objc func dragOlive(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        self.view.bringSubviewToFront(oliveOutlet)
        oliveOutlet.center = CGPoint(x: oliveOutlet.center.x + translation.x, y: oliveOutlet.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == .ended {
            if (oliveOutlet.center.x >= 50 && oliveOutlet.center.x <= 370 && oliveOutlet.center.y >= 280 && oliveOutlet.center.y <= 610){
                let newOlive = "olives.png"
                let oliveImage = UIImage(named: newOlive)
                let oliveNew = UIImageView(image: oliveImage)
                oliveNew.frame = oliveOutlet.frame
                oliveNew.contentMode = oliveOutlet.contentMode
                oliveNew.tag = tags
                view.addSubview(oliveNew)
                
                NSLog("x = " + oliveOutlet.center.x.description)
                NSLog("y = " + oliveOutlet.center.y.description)
                
                oliveOutlet.center.x = 135
                oliveOutlet.center.y = 760
                
                oliveOn += 1;
                tags += 1;
            }
        }
    }
    
    @objc func startGameTimer() {
        //count down the timer by 1
        gameInt -= 1;
        timeLabel.text = String(gameInt)
        
        //If the timer reaches 0
        if (gameInt == 0) {
            gameTimer.invalidate()
            
            if let player = player, player.isPlaying {
                //stop playback
                player.stop()
            }

            //go to the death screen
            let vc = storyboard?.instantiateViewController(identifier: "death") as! DeathViewController
            vc.modalPresentationStyle = .fullScreen
            //send the scoreInt and playerName information
            vc.scoreInt = scoreInt
            vc.playerName = playerName
            present(vc, animated: true)
        }
        
    }
    
    //when the button is clicked, run checkPizza
    @IBAction func checkPizza(_ sender: Any) {
        
        
        //while there is more than 1 tag
        while tags >= 1 {
            //remove the image (all the placed toppings)
            let viewWithTag = self.view.viewWithTag(tags)
            viewWithTag?.removeFromSuperview()
            tags -= 1
        }
        
        //set the tags to 1
        if(tags == 0) {
            tags = 1
        }
        
        //if the types and amounts of toppings placed on the pizza match the types and amounts needed
        if (pepperoniOn == pepperoniAmount && onionOn == onionAmount && pepperOn == pepperAmount && oliveOn == oliveAmount) {
            
            //set up player and play
            let bellUrlString = Bundle.main.path(forResource: "bell", ofType: "mp3")
            
            do {
                try AVAudioSession.sharedInstance().setMode(.default)
                try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
                
                guard let bellUrlString = bellUrlString else {
                    return
                }
                
                player2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: bellUrlString))
                
                guard let player2 = player2 else {
                    return
                }
                
                player2.play()
            }
            catch {
                
            }
            
            //increase the score by 1
            scoreInt += 1
            scoreLabel.text = String(scoreInt)
            
            //reset the timer
            gameInt = 10
            timeLabel.text = String(gameInt)
            
            //recalculate the toppings needed
            total = (scoreInt / 3) + 1
            pepperoniAmount = Int.random(in: 0...total)
            onionAmount = Int.random(in: 0...(total-pepperoniAmount))
            pepperAmount = Int.random(in: 0...(total-(pepperoniAmount+onionAmount)))
            oliveAmount = total - (pepperoniAmount + onionAmount + pepperAmount)
            
            pepperoniLabel.text = String(pepperoniAmount)
            onionLabel.text = String(onionAmount)
            pepperLabel.text = String(pepperAmount)
            oliveLabel.text = String(oliveAmount)
            
            //reset the toppings on the pizza
            pepperoniOn = 0
            onionOn = 0
            pepperOn = 0
            oliveOn = 0
        }
        
        //if the types and amounts of toppings dont match
        else {
            //stop the timer
            gameTimer.invalidate()
            
            if let player = player, player.isPlaying {
                //stop playback
                player.stop()
            }

            //go to the death screen
            let vc = storyboard?.instantiateViewController(identifier: "death") as! DeathViewController
            vc.modalPresentationStyle = .fullScreen
            //send the score and player information
            vc.scoreInt = scoreInt
            vc.playerName = playerName
            present(vc, animated: true)
        }
    }
    

}
