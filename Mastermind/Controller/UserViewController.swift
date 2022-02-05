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
    
    let defaults = UserDefaults.standard
    
    // viewDidLoad function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Connect to the UserDefaults
        //let defaults = UserDefaults.standard
        
        // Variables
        let win: Int = defaults.integer(forKey: "Win")
        let loss: Int = defaults.integer(forKey: "Loss")
        let played: Int = defaults.integer(forKey: "Played")
        var winPercent: Double = 0.0

        // Set the labels with the User Default Data
        gamesPlayedLabel.text = "Games Played: \(played)"
        totalWinsLabel.text = "Total Wins: \(win)"
        totalLossesLabel.text = "Total Losses: \(loss)"

        // Avoid division by zero if no games have been played yet
        if played != 0 {
            winPercent = (Double(win) / Double(played)) * 100
            percentWinsLabel.text = String(format: "Win Percentage: %.1f", winPercent)
        } else {
            percentWinsLabel.text = "Win Percentage: 0%"
        }

        // Calculate the win percentage and set the label using User Default Data
        switch Int(winPercent) {
        case 1...35:
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
            ratingLabel.text = "No Stars Yet"
        }
    }
    
    // Close the screen when pressed
    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // Reset the user defaults to 0
    @IBAction func resetButtonPressed(_ sender: UIButton) {
        defaults.set(0, forKey: k.uDefaultKeys.win)
        defaults.set(0, forKey: k.uDefaultKeys.loss)
        defaults.set(0, forKey: k.uDefaultKeys.played)
        self.dismiss(animated: true, completion: nil)
        
    }
}
