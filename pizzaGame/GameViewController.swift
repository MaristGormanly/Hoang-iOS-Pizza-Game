//
//  GameViewController.swift
//  pizzaGame
//
//  Created by Timothy Hoang on 3/28/21.
//  Copyright © 2021 Timothy Hoang. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    
    @IBOutlet var timeLabel: UILabel!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var pepperoniLabel: UILabel!
    @IBOutlet weak var onionLabel: UILabel!
    @IBOutlet weak var pepperLabel: UILabel!
    @IBOutlet weak var oliveLabel: UILabel!
    
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var pepperoniOutlet: UIImageView!
    @IBOutlet weak var onionOutlet: UIImageView!
    @IBOutlet weak var oliveOutlet: UIImageView!
    @IBOutlet weak var pepperOutlet: UIImageView!
    
    public var scoreHandler: ((Int) -> Void)?
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pepperoniOutlet.translatesAutoresizingMaskIntoConstraints = true
        self.onionOutlet.translatesAutoresizingMaskIntoConstraints = true
        self.oliveOutlet.translatesAutoresizingMaskIntoConstraints = true
        self.pepperOutlet.translatesAutoresizingMaskIntoConstraints = true
        
        gameInt = 10
        timeLabel.text = String(gameInt)
        
        total = (scoreInt / 3) + 1
        pepperoniAmount = Int.random(in: 0...total)
        onionAmount = Int.random(in: 0...(total-pepperoniAmount))
        pepperAmount = Int.random(in: 0...(total-(pepperoniAmount+onionAmount)))
        oliveAmount = total - (pepperoniAmount + onionAmount + pepperAmount)
        
        pepperoniLabel.text = String(pepperoniAmount)
        onionLabel.text = String(onionAmount)
        pepperLabel.text = String(pepperAmount)
        oliveLabel.text = String(oliveAmount)
        
        var pepperoniPanGesture  = UIPanGestureRecognizer()
        var pepperPanGesture  = UIPanGestureRecognizer()
        var olivePanGesture  = UIPanGestureRecognizer()
        var onionPanGesture  = UIPanGestureRecognizer()
        
        //pan gesture for dragging an image
        pepperoniPanGesture = UIPanGestureRecognizer(target: self, action: #selector(GameViewController.dragPepperoni(_:)))
        pepperPanGesture = UIPanGestureRecognizer(target: self, action: #selector(GameViewController.dragPepper(_:)))
        onionPanGesture = UIPanGestureRecognizer(target: self, action: #selector(GameViewController.dragOnion(_:)))
        olivePanGesture = UIPanGestureRecognizer(target: self, action: #selector(GameViewController.dragOlive(_:)))
        
        pepperoniOutlet.addGestureRecognizer(pepperoniPanGesture)
        pepperOutlet.addGestureRecognizer(pepperPanGesture)
        oliveOutlet.addGestureRecognizer(olivePanGesture)
        onionOutlet.addGestureRecognizer(onionPanGesture)
        
        NSLog("x is " + pepperOutlet.center.x.description)
        NSLog("y is " + pepperOutlet.center.y.description)
        
        NSLog("x is " + onionOutlet.center.x.description)
        NSLog("y is " + onionOutlet.center.y.description)
        
        NSLog("x is " + oliveOutlet.center.x.description)
        NSLog("y is " + oliveOutlet.center.y.description)

        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(GameViewController.startGameTimer), userInfo: nil, repeats: true)
        
    }
    
    @objc func dragPepperoni(_ sender:UIPanGestureRecognizer){
        
        
        let translation = sender.translation(in: self.view)
        self.view.bringSubviewToFront(pepperoniOutlet)
        pepperoniOutlet.center = CGPoint(x: pepperoniOutlet.center.x + translation.x, y: pepperoniOutlet.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == .ended {
            let newPepperoni = "pepperonis.png"
            let pepperoniImage = UIImage(named: newPepperoni)
            let pepperoniNew = UIImageView(image: pepperoniImage)
            pepperoniNew.frame = pepperoniOutlet.frame
            pepperoniNew.tag = tags
            view.addSubview(pepperoniNew)
            
            pepperoniOutlet.center.x = 135.5
            pepperoniOutlet.center.y = 667.5
            
            pepperoniOn += 1;
            tags += 1;

        }
        
    }
    
    @objc func dragPepper(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        self.view.bringSubviewToFront(pepperOutlet)
        pepperOutlet.center = CGPoint(x: pepperOutlet.center.x + translation.x, y: pepperOutlet.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == .ended {
            let newPepper = "peppers.png"
            let pepperImage = UIImage(named: newPepper)
            let pepperNew = UIImageView(image: pepperImage)
            pepperNew.frame = pepperOutlet.frame
            pepperNew.tag = tags
            view.addSubview(pepperNew)
            
            pepperOutlet.center.x = 280
            pepperOutlet.center.y = 760.5
            
            pepperOn += 1;
            tags += 1;

        }
    
    }
    
    @objc func dragOnion(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        self.view.bringSubviewToFront(onionOutlet)
        onionOutlet.center = CGPoint(x: onionOutlet.center.x + translation.x, y: onionOutlet.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == .ended {
            let newOnion = "onions.png"
            let onionImage = UIImage(named: newOnion)
            let onionNew = UIImageView(image: onionImage)
            onionNew.frame = onionOutlet.frame
            onionNew.tag = tags
            view.addSubview(onionNew)
            
            onionOutlet.center.x = 281
            onionOutlet.center.y = 673
            
            onionOn += 1;
            tags += 1;

        }
    }
    
    @objc func dragOlive(_ sender:UIPanGestureRecognizer){
        let translation = sender.translation(in: self.view)
        self.view.bringSubviewToFront(oliveOutlet)
        oliveOutlet.center = CGPoint(x: oliveOutlet.center.x + translation.x, y: oliveOutlet.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: self.view)
        
        if sender.state == .ended {
            let newOlive = "olives.png"
            let oliveImage = UIImage(named: newOlive)
            let oliveNew = UIImageView(image: oliveImage)
            oliveNew.frame = oliveOutlet.frame
            oliveNew.tag = tags
            view.addSubview(oliveNew)
            
            oliveOutlet.center.x = 135
            oliveOutlet.center.y = 760
            
            oliveOn += 1;
            tags += 1;

        }
    }
    
    @objc func startGameTimer() {
        
        gameInt -= 1;
        timeLabel.text = String(gameInt)
        
        //If the timer reaches 0
        if (gameInt == 0) {
            gameTimer.invalidate()

            let vc = storyboard?.instantiateViewController(identifier: "death") as! DeathViewController
            vc.modalPresentationStyle = .fullScreen
            vc.scoreInt = scoreInt
            vc.playerName = playerName
            present(vc, animated: true)
        }
        
    }
    
    @IBAction func checkPizza(_ sender: Any) {
        
        while tags >= 1 {
            let viewWithTag = self.view.viewWithTag(tags)
            viewWithTag?.removeFromSuperview()
            tags -= 1
        }
        
        if(tags == 0) {
            tags = 1
        }
        
        if (pepperoniOn == pepperoniAmount && onionOn == onionAmount && pepperOn == pepperAmount && oliveOn == oliveAmount) {
            
            scoreInt += 1
            scoreLabel.text = String(scoreInt)
            
            gameInt = 10
            timeLabel.text = String(gameInt)
            
            total = (scoreInt / 3) + 1
            pepperoniAmount = Int.random(in: 0...total)
            onionAmount = Int.random(in: 0...(total-pepperoniAmount))
            pepperAmount = Int.random(in: 0...(total-(pepperoniAmount+onionAmount)))
            oliveAmount = total - (pepperoniAmount + onionAmount + pepperAmount)
            
            pepperoniOn = 0
            onionOn = 0
            pepperOn = 0
            oliveOn = 0
            
            pepperoniLabel.text = String(pepperoniAmount)
            onionLabel.text = String(onionAmount)
            pepperLabel.text = String(pepperAmount)
            oliveLabel.text = String(oliveAmount)
        }
        
        else {
            gameTimer.invalidate()
            
            NotificationCenter.default.post(name: Notification.Name("scoreInt"), object: scoreInt)

            let vc = storyboard?.instantiateViewController(identifier: "death") as! DeathViewController
            vc.modalPresentationStyle = .fullScreen
            vc.scoreInt = scoreInt
            vc.playerName = playerName
            present(vc, animated: true)
        }
    }
    

}
