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
    let defaults = UserDefaults.standard
    var win: Int = 0
    var loss: Int = 0
    var played: Int = 0
    var winPercent: Double = 0.0
    
    // viewDidLoad function
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabels()
    }
    
    // Set the label values
    func setLabels() {
        win = defaults.integer(forKey: "Win")
        loss = defaults.integer(forKey: "Loss")
        played = defaults.integer(forKey: "Played")
        winPercent = 0.0
        
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
        
        // Notify player of the reset
        let alert = UIAlertController(title: k.appTitle, message: "Game History Has Been Reset", preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
        setLabels()
    }
}
