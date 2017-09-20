//
//  ViewController.swift
//  ColorChangerGame
//
//  Created by Aadit Kapoor on 6/11/17.
//  Copyright © 2017 Aadit Kapoor. All rights reserved.
//

import UIKit
import SwiftSpinner
import Whisper
import SCLAlertView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playSegue" {
            SwiftSpinner.show(duration: 2.0, title: "Loading Game")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func aboutButton(_ sender: Any) {
        
        SCLAlertView().showInfo("About", subTitle: "Designed and Developed by Aadit Kapoor")
    }
    @IBAction func helpButton(_ sender: UIButton) {
        
        SCLAlertView().showInfo("Help", subTitle: "The objective of the game is to select the Color of the text.")
    }

}

