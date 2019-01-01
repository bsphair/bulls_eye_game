//
//  ViewController.swift
//  hit_me_game
//
//  Created by Brian Phair on 12/31/18.
//  Copyright © 2018 Brian Phair. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int = 0
    var targetValue: Int = 0
    var round: Int = 0
    var score = 0
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)

        startNewGame()
    }

    @IBAction func showAlert() {
        let title: String

        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        
        score += points
        
        
        if difference == 0{
            title = "Perfect!"
            points += 100
        }
        else if difference < 5{
            title =  "You almost had it!"
        }
        else if difference < 10{
            title = "Pretty good!"
        }
        else{
            title = "Not even close..."
        }
        let message = "You scored \(points) points"

        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func sliderMoved(_ slider: UISlider){
        let roundedValue = slider.value.rounded()
        
        currentValue = Int(roundedValue)
    }
    
    
    func startNewRound(){
        round += 1
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
    }

    func updateLabels(){
        targetLabel.text = String(targetValue)
        roundLabel.text = String(round)
        scoreLabel.text = String(score)
    }

    
    @IBAction func startNewGame() {
        score = 0
        round = 0
        startNewRound()
    }
    
    

    
}

