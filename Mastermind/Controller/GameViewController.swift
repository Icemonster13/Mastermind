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
    @IBOutlet weak var btnValidateAnswer: UIButton!
    @IBOutlet weak var btnReset: UIButton!
    @IBOutlet weak var btnQuit: UIButton!
    @IBOutlet weak var btnInstructions: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    
    // Variable link to the Brain struct
    var codeBrain = Brain()
    
    // Variable link to User Default Data for persistent data
    let defaultData = UserDefaults.standard
    
    // Set a global variable to track whether the game should count
    var gameStarted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Format all buttons using the button collections, hide the master code buttons, and start the game
        formatView()
        hideMasterCode(hide: true)
        startGame()
    }
    
    @IBAction func btnReset(_ sender: UIButton) {
        if gameStarted == true {
            sendAlert(message: k.response.quitafterstart)
        } else {
            // Reset the game and start over
            formatView()
            hideMasterCode(hide: true)
            startGame()
        }
    }
    
    @IBAction func btnQuit(_ sender: UIButton) {
        if gameStarted == true {
            sendAlert(message: k.response.quitafterstart)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // Each click loops through the colors of the guess button
    @IBAction func btnGuessClicked(_ sender: UIButton) {
        if codeBrain.guessCounter > 0 {
            // Clear the message from the status label
            statusLabel.text = ""
            // Change the color of the button
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
        
        // This signifies the starting of the game and counts towards games played
        if gameStarted == false {
            // Count the game as started and add it to the User Defaults for tracking
            let totalPlayed = defaultData.integer(forKey: k.uDefaultKeys.played)
            defaultData.set(totalPlayed + 1, forKey: k.uDefaultKeys.played)
            gameStarted = true
        }

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
        if validationResult == k.response.win {
            hideMasterCode(hide: false)
            btnValidateAnswer.setTitle("👍", for: .normal)
            btnValidateAnswer.isUserInteractionEnabled = false
            statusLabel.text = k.response.win
            let totalWins = defaultData.integer(forKey: k.uDefaultKeys.win)
            defaultData.set(totalWins + 1, forKey: k.uDefaultKeys.win)
            sendAlert(message: validationResult)
        } else if validationResult == k.response.incomplete {
            statusLabel.text = k.response.incomplete
            //sendAlert(message: validationResult)
        } else {
            //Set the Black and White Hint Pegs
            let blackPegPosition = (codeBrain.guessCounter * 100) + 1
            let whitePegPosition = (codeBrain.guessCounter * 100) + 2
            let blackLabel = self.view.viewWithTag(blackPegPosition) as! UILabel
            blackLabel.text = " \(codeBrain.hintPeg[0]) \(codeBrain.hintPeg[1]) "
            let whiteLabel = self.view.viewWithTag(whitePegPosition) as! UILabel
            whiteLabel.text = " \(codeBrain.hintPeg[2]) \(codeBrain.hintPeg[3]) "
            // Check to ensure it is not past the 10th guess
            // If it is, then stop the game
            if codeBrain.guessCounter == 10 {
                hideMasterCode(hide: false)
                btnValidateAnswer.setTitle("👎", for: .normal)
                statusLabel.text = k.response.lose
                let totalLosses = defaultData.integer(forKey: k.uDefaultKeys.loss)
                defaultData.set(totalLosses + 1, forKey: k.uDefaultKeys.loss)
                sendAlert(message: k.response.lose)
            } else {
                statusLabel.text = k.response.incorrect
                //sendAlert(message: validationResult)
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
            button.layer.cornerRadius = 20
            button.layer.borderWidth = 1
            button.backgroundColor = UIColor.clear
        }
        // Set the statusLabel text
        statusLabel.text = "Can you guess the code?"
        // Turn off the validate button
        btnValidateAnswer.isUserInteractionEnabled = false
        // Disable the Reset button until the first play
        btnReset.isUserInteractionEnabled = false
        // Reset the guess counter
        codeBrain.guessCounter = 0
        // Reset the hint labels
        for counter in 1...10 {
            let blackPegPosition = (counter * 100) + 1
            let whitePegPosition = (counter * 100) + 2
            let blackLabel = self.view.viewWithTag(blackPegPosition) as! UILabel
            blackLabel.text = " ▪️ ▪️ "
            let whiteLabel = self.view.viewWithTag(whitePegPosition) as! UILabel
            whiteLabel.text = " ▪️ ▪️ "
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
        gameStarted = false
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
        // Declare Alert message
        let alert = UIAlertController(title: k.appTitle, message: message, preferredStyle: UIAlertController.Style.alert)
        
        if message == k.response.win || message == k.response.lose {
            let yes = UIAlertAction(title: "YES", style: .default, handler: { (action) -> Void in
                // Reset the view to the original
                self.formatView()
                self.hideMasterCode(hide: true)
                self.startGame()
            })
            let no = UIAlertAction(title: "NO", style: .default, handler: { (action) -> Void in
                // Dismiss the screen and return to the EntryViewController
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(yes)
            alert.addAction(no)
        } else if message == k.response.quitafterstart {
            let yes = UIAlertAction(title: "YES", style: .default) { (action) -> Void in
                // Dismiss the screen and return to the EntryViewController
                self.dismiss(animated: true, completion: nil)
            }
            let no =  UIAlertAction(title: "NO", style: .default) { (action) -> Void in
                print("Do Nothing")
            }
            alert.addAction(yes)
            alert.addAction(no)
        } else {
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
        }
        
        // Show the alert
        self.present(alert, animated: true, completion: nil)
    }
} // End ViewController
