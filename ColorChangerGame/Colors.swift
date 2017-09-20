//
//  Colors.swift
//  ColorChangerGame
//
//  Created by Aadit Kapoor on 6/12/17.
//  Copyright © 2017 Aadit Kapoor. All rights reserved.
//

import Foundation
import UIKit
import GameplayKit

var Colors:Dictionary<String,UIColor> = [
    "red": UIColor.red,
    "blue": UIColor.blue,
    "green": UIColor.green,
    "brown": UIColor.brown,
    "black" :UIColor.black,
    "cyan": UIColor.cyan,
    "yellow": UIColor.yellow,
    "purple": UIColor.purple,
    "magenta": UIColor.magenta,
    "orange": UIColor.orange,
    "gray":UIColor.gray
]

func getRandomColorFromMain() -> String {
    let n = Int(arc4random_uniform(UInt32(Colors.count)) + 0)
    var x = Array(Colors.keys)
    return x[n]
}


func getThreeChoices(correctColor:String, colorOnText:String) -> [String] {
    var toReturn:[String] = []
    toReturn.append(correctColor)
    toReturn.append(colorOnText)
    toReturn.append(getRandomColorFromMain())
    
    let shuffled = GKRandomSource.sharedRandom().arrayByShufflingObjects(in: toReturn)
    return shuffled as! [String]
}
