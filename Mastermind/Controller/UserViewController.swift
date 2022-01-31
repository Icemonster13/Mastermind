//
//  UserViewController.swift
//  Mastermind
//
//  Created by Michael & Diana Pascucci on 1/30/22.
//

import UIKit

class UserViewController: UIViewController {

    // IB Outlets
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var gamesPlayedLabel: UILabel!
    @IBOutlet weak var totalWinsLabel: UILabel!
    @IBOutlet weak var totalLossesLabel: UILabel!
    @IBOutlet weak var percentWinsLabel: UILabel!
    
    // Variables
    var win: Int = 0
    var loss: Int = 0
    var played: Int = 0
    var winPercent: Double = 0.0
    
    // viewDidLoad function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard

        if let wins = defaults.integer(forKey: "Win") as Int? {
            win = wins
        }
        if let losses = defaults.integer(forKey: "Loss") as Int? {
            loss = losses
        }
        if let plays = defaults.integer(forKey: "Played") as Int? {
            played = plays
        }

        // Set the labels with the User Default Data
        gamesPlayedLabel.text = "Games Played: \(played)"
        totalWinsLabel.text = "Total Wins: \(win)"
        totalLossesLabel.text = "Total Losses: \(loss)"

        if played != 0 {
            winPercent = (Double(win) / Double(played)) * 100
            percentWinsLabel.text = String(format: "Win Percentage: %.1f", winPercent)
        } else {
            percentWinsLabel.text = "Win Percentage: 0%"
        }

        // Calculate the win percentage and set the label using User Default Data
        switch Int(winPercent) {
        case 0...35:
            ratingLabel.text = "⭐️"
        case 36...55:
            ratingLabel.text = "⭐️⭐️"
        case 56...75:
            ratingLabel.text = "⭐️⭐️⭐️"
        case 76...95:
            ratingLabel.text = "⭐️⭐️⭐️⭐️"
        case 96...100:
            ratingLabel.text = "⭐️⭐️⭐️⭐️⭐️"
        default:
            ratingLabel.text = ""
        }
    }
    
    // Close the screen when pressed
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
