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
    var playerOneScore = 0
    var playerTwoScore = 0
    var playerOneTurn = true
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var playerOneScoreLabel: UILabel!
    @IBOutlet weak var playerTwoScoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var playerTurnLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let roundedValue = slider.value.rounded()
        currentValue = Int(roundedValue)

        startNewGame()
        
        
        //load thumbnail images
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        //set up left image to slider
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        //set up right image to slider
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
    }

    @IBAction func showAlert() {
        let title, message: String
        
        
        //set up points
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference           //calculate actual points
        
        //determine if bonus points can be given
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
        
        //assign all points to current player
        if(playerOneTurn){
            playerOneScore += points
            message = "Player 1 scored \(points) points"
        }
        else{
            playerTwoScore += points
            message = "Player 2 scored \(points) points"
        }
        
    
        //set up alert message
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            action in
            self.startNewRound()
        })
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        playerOneTurn.toggle()  //switch player
    }
    
    
    @IBAction func sliderMoved(_ slider: UISlider){
        let roundedValue = slider.value.rounded()
        
        currentValue = Int(roundedValue)
    }
    
    
    func startNewRound(){

        
        
        if(playerOneTurn){
            round += 1
        }
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        updateLabels()
        
        
        
        if(round > 10){
            if(playerOneScore > playerTwoScore){
                let alert = UIAlertController(title: "Player 1 Wins!!!", message: "Congrats Player 1!!!", preferredStyle: .alert)
                let action = UIAlertAction(title: "Play Again", style: .default, handler:{
                    action in
                    self.startNewGame()
                })
                alert.addAction(action)
                present(alert, animated: true, completion: nil)
            }
        }
    }

    func updateLabels(){
        if(playerOneTurn){
            playerTurnLabel.text = "Player 1"
        }
        else{
            playerTurnLabel.text = "Player 2"
        }
        targetLabel.text = String(targetValue)
        roundLabel.text = String(round)
        playerOneScoreLabel.text = String(playerOneScore)
        playerTwoScoreLabel.text = String(playerTwoScore)
    }

    
    @IBAction func startNewGame() {
        playerOneScore = 0
        playerTwoScore = 0
        round = 0
        startNewRound()
    }
    
    

    
}

