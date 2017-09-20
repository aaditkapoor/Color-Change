//
//  GameViewController.swift
//  ColorChangerGame
//
//  Created by Aadit Kapoor on 6/12/17.
//  Copyright © 2017 Aadit Kapoor. All rights reserved.
//

import UIKit
import RandomColorSwift
import SCLAlertView
import Whisper
import SwiftSpinner
import TTGSnackbar
import SwiftySound

class GameViewController: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var colorNameLabel: UILabel!
    @IBOutlet weak var choiceSelected: UISegmentedControl!
    
    @IBOutlet weak var lifesOutlet: UIButton!
    
    
    var interval = 1.4
    var timer:Timer!
    var count = 1.0
    var score = 0
    
    var lifes = 3
    
    @IBOutlet weak var speedOutlet: UISegmentedControl!
    
    @IBAction func pauseAction(_ sender: UIButton) {
        timer.invalidate()
        SCLAlertView().showNotice("Stopped", subTitle: "Game is stopped!")
        
        let mu = Murmur(title: "Please press Go Back to exit the game")
        Whisper.show(whistle: mu)
        choiceSelected.isUserInteractionEnabled = false
        speedOutlet.isUserInteractionEnabled = false
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: true)
        choiceSelected.selectedSegmentIndex = UISegmentedControlNoSegment
    }
    
    @IBAction func speedChangingAction(_ sender: UISegmentedControl) {
        
        switch(sender.selectedSegmentIndex) {
        case 0:
            SCLAlertView().showInfo("Information", subTitle: "Changing speed to 1x")
            interval = 1.2
            if timer.isValid {
                timer.invalidate()
            }
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: true)

        case 1:
            SCLAlertView().showInfo("Information", subTitle: "Changing speed to 2x")
            interval = 0.5
            if timer.isValid {
                timer.invalidate()
            }
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: true)

        default:
            interval = 1.0
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(changeBackground), userInfo: nil, repeats: true)

        }
        
        
        
    }
    
    
    
    func point(correct: Bool) {
        if correct {
            score = score + 1
            scoreLabel.text = "Score: \(score)"

            
        }
        else {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    func showSnackBar(correct:Bool) {
        let correct_l = "Correct! Keep going..."
        let wrong = "Wrong! Please try again..."
        if correct {
            let snackbar = TTGSnackbar.init(message: correct_l, duration: .short)
            snackbar.show()
        }
        else {
            let snackbar = TTGSnackbar.init(message: wrong, duration: .short)
            snackbar.show()
        }
    }
    
    func checkForLife( life:Int) -> Bool {
        if life == 3 {
            return false
            
        }
        else {
            return true
            
        }
    }
    
    func setLife(life:Int) {
        lifesOutlet.setTitle("\(life)", for: .normal)
    }
    
    @IBAction func choiceSelectedAction(_ sender: UISegmentedControl) {
        // Checking Choices if wrong exit timer and show dialog
        
        
        switch(sender.selectedSegmentIndex) {
        case UISegmentedControlNoSegment:
            SCLAlertView().showError("Color not loaded.", subTitle: "Color is not loaded yet. Please restart the game.")
        case 0:
            if colorNameLabel.textColor == Colors[sender.titleForSegment(at: 0)!.lowercased()] {
                showSnackBar(correct: true)
                point(correct: true)
                Sound.play(file: "correct.wav")
                
                }
            else {
                
             
                    print (lifes)

                    lifes = lifes - 1
                showSnackBar(correct: false)
                point(correct: false)
                Sound.play(file: "wrong.wav")
                gameOver()
                


            }
        case 1:
            if colorNameLabel.textColor == Colors[sender.titleForSegment(at: 1)!.lowercased()] {
                showSnackBar(correct: true)
                point(correct: true)
                Sound.play(file: "correct.wav")


            }
            else {
                
              
                    lifes = lifes - 1


                showSnackBar(correct: false)
                point(correct: false)
                Sound.play(file: "wrong.wav")
                gameOver()

                


            }
        case 2:
            if colorNameLabel.textColor == Colors[sender.titleForSegment(at: 2)!.lowercased()] {
                showSnackBar(correct: true)
                point(correct: true)
                Sound.play(file: "correct.wav")


            }
            else {
                
                    lifes = lifes - 1

                  
                    

                showSnackBar(correct: false)
                point(correct: false)
                Sound.play(file: "wrong.wav")
                gameOver()



            }
            
        default:
            SCLAlertView().showError("Error", subTitle: "Oops!")
            
            
        }
        
        

        
    }
    
    func gameOver() {
        SCLAlertView().showNotice("Game Over", subTitle: "Thanks for playing.")
        choiceSelected.isUserInteractionEnabled = false
        speedOutlet.isUserInteractionEnabled = false
        timer.invalidate()
        count = 1
        
        
        
    }
    
    
    func changeBackground() {
        if count == 1000.0 {
            timer.invalidate()
            count = 1.0
            gameOver()
        }
        else {
            count = count + 1.0
            let text = getRandomColorFromMain().capitalized
            let textc = getRandomColorFromMain()
            let (textColor) = Colors[textc]!
            colorNameLabel.text! = text
            colorNameLabel.textColor! = textColor
            
            
            var choices = getThreeChoices(correctColor: textc, colorOnText: text)
            var index = 0
            for i in choices {
                choiceSelected.setTitle(i.capitalized, forSegmentAt: index)
                index = index + 1
            }
        }
    }
    
    func tryAgain() {
        timer.invalidate()
        count = 1
    }
    
    
    
}
