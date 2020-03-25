//
//  ViewController.swift
//  EggTimer
//
//  Created by Bola Gadalla on 17/12/19.
//  Copyright © 2019 Bola Gadalla. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController
{
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var prograssBar: UIProgressView!
    
    let eggTimer = ["Soft": 3, "Medium": 8, "Hard": 12] // Creates a dictionary
    var secondsTillEggCooked = 0 // Creates a variable to hold the value of the key
    var timer = Timer() // To hold the timer function so we can have more control over it
    var totalTimeTillCooked = 0 // The total time till cooked
    var player : AVAudioPlayer!
    
    @IBAction func HardnessSelected(_ sender: UIButton)
    {
        timer.invalidate() // If there was any other timer then it stops it
        prograssBar.progress = 0
        secondsTillEggCooked = 0
        let hardness = sender.currentTitle! // Gets the value through the key of the button title // Soft, Medium, Hard
        totalTimeTillCooked = eggTimer[hardness]! //* 60 // Sets the secondTillEggsCooked to the value * 60 for mins
        topText.text = "\(hardness) cooked eggs in prograss"
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true) // Creates a loop that runs a function every second
        
    }
    
    /// This is called for the count down of timer
    @objc func updateCounter()
    {
        //example functionality
        if secondsTillEggCooked < totalTimeTillCooked
        {
            secondsTillEggCooked += 1
            prograssBar.progress = (Float(secondsTillEggCooked) / Float(totalTimeTillCooked)) // Calculates the prograss bar value
        }
        else
        {
            timer.invalidate() // Stops the timer
            topText.text = "Done!" // Once the timer is zero then change the text to "Done"
            playSound(noteSound: "alarm_sound")
        }
    }
    
    func playSound(noteSound: String)
    {
        let url = Bundle.main.url(forResource: noteSound, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
