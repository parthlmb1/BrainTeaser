//
//  GameVC.swift
//  BrainTeaser
//
//  Created by Parth Lamba on 21/03/18.
//  Copyright © 2018 Parth Lamba. All rights reserved.
//

import UIKit
import pop

class GameVC: UIViewController {

    @IBOutlet weak var yesBtn: CustomButton!
    @IBOutlet weak var noBtn: CustomButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var timerLbl: UILabel!
    
    var currentCard: Card!
    var previouscard: Card!
    
    var seconds = 60
    var timer = Timer()
    var isTimerRunning: Bool = false
    
    var correctAns: Int = 0
    var wrongAns: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        currentCard = createCardFromNib()
        previouscard = currentCard
        currentCard.center = AnimationEngine.screenCenterPosition
        self.view.addSubview(currentCard)
    }

    @IBAction func yesPressed(sender: UIButton){
        if sender.titleLabel?.text == "YES" {
            checkAnswer(guess: true)
        } else {
            startTimer()
            titleLbl.text = "Does this card match the previous ?"
        }
        showNextCard()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,  selector: (#selector(GameVC.updateTimer)), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        if seconds != 0 {
            seconds -= 1
            if seconds <= 9 {
                timerLbl?.text = "00:0\(seconds)"
            } else {
                timerLbl?.text = "00:\(seconds)"
            }
            
        } else {
            showScore()
        }
    }
    
    func showScore(){
        let alert = UIAlertController(title: "Game Over", message: "Correct Answers: \(correctAns) \n Wrong Answers: \(wrongAns)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        timer.invalidate()
        seconds = 60
        timerLbl?.text = "01:00"
        
        if !noBtn.isHidden {
            noBtn.isHidden = true
            yesBtn.setTitle("START", for: .normal)
            titleLbl?.text = "Click the start Button to begin."
            correctAns = 0
            wrongAns = 0
        }
    }
    
    @IBAction func noPressed(sender: UIButton){
        checkAnswer(guess: false)
        showNextCard()
    }
    
    func showNextCard() {
        if let current = currentCard {
            let cardToRemove = current
            previouscard = cardToRemove
            currentCard = nil
            AnimationEngine.animateToPosition(view: cardToRemove, position: AnimationEngine.offScreenLeftPosition, completion: { (anim: POPAnimation?, finished: Bool) in
                cardToRemove.removeFromSuperview()
            })
        }
        
        if let next = createCardFromNib() {
            next.center = AnimationEngine.offScreenRightPosition
            self.view.addSubview(next)
            currentCard = next
            
            if noBtn.isHidden {
                noBtn.isHidden = false
                yesBtn.setTitle("YES", for: .normal)
            }
            
            AnimationEngine.animateToPosition(view: next, position: AnimationEngine.screenCenterPosition, completion: { (anim: POPAnimation?, finished: Bool) in
                
            })
        }
    }
    
    func createCardFromNib() -> Card? {
        return Bundle.main.loadNibNamed("Card", owner: self, options: nil)?[0] as? Card
    }
    
    func checkAnswer(guess: Bool) -> Bool{
        let ans = currentCard.currentShape == previouscard.currentShape
        
        if guess == ans {
            correctAns += 1
        } else {
            wrongAns += 1
        }
        return guess == ans
    }
}
