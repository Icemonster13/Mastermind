//
//  GameViewController.swift
//  Mastermind
//
//  Created by Michael & Diana Pascucci on 1/17/22.
//

import UIKit

class GameViewController: UIViewController {

    //IBOutlet Collections
    @IBOutlet var allButtons: [UIButton]!
    @IBOutlet var masterButtons: [UIButton]!
    @IBOutlet var guessButtons: [UIButton]!
    
    //IBOutlet Buttons
    @IBOutlet weak var btnMasterCode1: UIButton!
    @IBOutlet weak var btnMasterCode2: UIButton!
    @IBOutlet weak var btnMasterCode3: UIButton!
    @IBOutlet weak var btnMasterCode4: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnValidateAnswer: UIButton!
    
    // Variable link to the Brain struct
    var codeBrain = Brain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Format all buttons using the button collections, hide the master code buttons, and start the game
        formatView()
        hideMasterCode(hide: true)
        startGame()
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        // Reset the view to the original
        formatView()
        hideMasterCode(hide: true)
        startGame()
    }
    
    // Each click loops through the colors of the guess button
    @IBAction func btnGuessClicked(_ sender: UIButton) {
        if codeBrain.guessCounter > 0 {
            switch sender.backgroundColor {
            case UIColor.clear:
                sender.backgroundColor = UIColor.red
            case UIColor.red:
                sender.backgroundColor = UIColor.orange
            case UIColor.orange:
                sender.backgroundColor = UIColor.yellow
            case UIColor.yellow:
                sender.backgroundColor = UIColor.green
            case UIColor.green:
                sender.backgroundColor = UIColor.blue
            case UIColor.blue:
                sender.backgroundColor = UIColor.purple
            default:
                sender.backgroundColor = UIColor.clear
            }
        } else {
            return
        }
    } // End btnGuessClicked()
    
    // Action when the Check button is clicked
    @IBAction func btnValidate(_ sender: UIButton) {
        // Assign the guess colors to the guessCodeArray
        let guessStart: Int = (codeBrain.guessCounter * 4) - 3
        let guessEnd: Int = codeBrain.guessCounter * 4
        
        // Enable the reset button
        btnReset.isUserInteractionEnabled = true
        
        for tagvalue in guessStart...guessEnd {
            let button = self.view.viewWithTag(tagvalue) as! UIButton
            codeBrain.guessCodeArray[tagvalue - 1] = button.backgroundColor!
        }
        
        // Validate the guess code against the master code and return the results
        let validationResult = codeBrain.validateAnswer()
        if validationResult == "Congratulations, you win!" {
            hideMasterCode(hide: false)
            btnValidateAnswer.setTitle("", for: .normal)
            sendAlert(message: validationResult)
        } else if validationResult == "You did not choose all colors. Please try again." {
            sendAlert(message: validationResult)
        } else {
            //Set the Black and White Hint Pegs
            let blackPegPosition = (codeBrain.guessCounter * 100) + 1
            let whitePegPosition = (codeBrain.guessCounter * 100) + 2
            let blackLabel = self.view.viewWithTag(blackPegPosition) as! UILabel
            blackLabel.text = " BL: \(codeBrain.blackPeg)"
            let whiteLabel = self.view.viewWithTag(whitePegPosition) as! UILabel
            whiteLabel.text = " WH: \(codeBrain.whitePeg)"
            // Check to ensure it is not past the 10th guess
            // If it is, then stop the game
            if codeBrain.guessCounter == 10 {
                hideMasterCode(hide: false)
                btnValidateAnswer.setTitle("", for: .normal)
                sendAlert(message: "You have failed to guess the proper code. Would you like to play again?")
                // Insert RESET code here
            } else {
                sendAlert(message: validationResult)
                // Increase the guessCounter
                codeBrain.guessCounter += 1
                // Enable the appropriate guess buttons
                buttonStatus(guessCounter: codeBrain.guessCounter)
            }
        }
    } // End btnValidate()
    
    //MARK : Format the screen
    
    func formatView() {
        // Format all buttons using the button collections
        for button in allButtons {
            button.layer.cornerRadius = 10
            button.layer.borderWidth = 1
            button.backgroundColor = UIColor.clear
            //button.isUserInteractionEnabled = false
        }
        // Turn off the validate button
        btnValidateAnswer.isUserInteractionEnabled = false
        // Set the Reset button title
        btnReset.setTitle("RESET", for: .normal)
        // Turn off the Reset button until the first guesses are made
        btnReset.isUserInteractionEnabled = false
        // Reset the guess counter
        codeBrain.guessCounter = 0
        // Reset the hint labels
        for counter in 1...10 {
            let blackPegPosition = (counter * 100) + 1
            let whitePegPosition = (counter * 100) + 2
            let blackLabel = self.view.viewWithTag(blackPegPosition) as! UILabel
            blackLabel.text = " BL: "
            let whiteLabel = self.view.viewWithTag(whitePegPosition) as! UILabel
            whiteLabel.text = " WH: "
        }
    } // End formatView()
    
    //MARK -- Hide the Master Code buttons
    
    func hideMasterCode(hide: Bool) {
        btnMasterCode1.isHidden = hide
        btnMasterCode2.isHidden = hide
        btnMasterCode3.isHidden = hide
        btnMasterCode4.isHidden = hide
    } // End hideMasterCode()
    
    //MARK -- Start the game
    
    func startGame() {
        // Get the master code and apply it to the master code buttons
        codeBrain.getMasterCode()
        btnMasterCode1.backgroundColor = codeBrain.masterCodeArray[0]
        btnMasterCode2.backgroundColor = codeBrain.masterCodeArray[1]
        btnMasterCode3.backgroundColor = codeBrain.masterCodeArray[2]
        btnMasterCode4.backgroundColor = codeBrain.masterCodeArray[3]
        btnValidateAnswer.setTitle("CHECK ANSWER", for: .normal)
        // Start the guessCounter
        codeBrain.guessCounter += 1
        // Enable the appropriate guess buttons
        buttonStatus(guessCounter: codeBrain.guessCounter)
        // Enable the Validation button
        btnValidateAnswer.isUserInteractionEnabled = true
    } // End startGame()
    
    //MARK -- Set the correct guess button status
    
    func buttonStatus(guessCounter: Int) {
        let guessStart: Int = (guessCounter * 4) - 3
        let guessEnd: Int = guessCounter * 4
        
        for button in guessButtons {
            button.isUserInteractionEnabled = false
        }
        for tagvalue in guessStart...guessEnd {
            let button = self.view.viewWithTag(tagvalue) as! UIButton
            button.isUserInteractionEnabled = true
        }
    } // End buttonStatus()

    
    //MARK -- Send Alerts, as required
    
    func sendAlert(message: String) {
        //Create the alert
        let alert = UIAlertController(title: "Mastermind", message: message, preferredStyle: UIAlertController.Style.alert)
        
        // Add a button
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        // Show the alert
        self.present(alert, animated: true, completion: nil)
    } // End sendAlert()
    
} // End ViewController
