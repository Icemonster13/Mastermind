//
//  Brain.swift
//  Mastermind
//
//  Created by Michael Pascucci on 12/24/21.
//

import UIKit

struct Brain {
    // Array of colors that can be chosen
    let colorArray = [UIColor.red, UIColor.orange, UIColor.yellow, UIColor.green, UIColor.blue, UIColor.purple]
    // Array of colors chosen by the user
    var guessCodeArray = [
        UIColor.clear, UIColor.clear, UIColor.clear, UIColor.clear,
        UIColor.clear, UIColor.clear, UIColor.clear, UIColor.clear,
        UIColor.clear, UIColor.clear, UIColor.clear, UIColor.clear,
        UIColor.clear, UIColor.clear, UIColor.clear, UIColor.clear,
        UIColor.clear, UIColor.clear, UIColor.clear, UIColor.clear,
        UIColor.clear, UIColor.clear, UIColor.clear, UIColor.clear,
        UIColor.clear, UIColor.clear, UIColor.clear, UIColor.clear,
        UIColor.clear, UIColor.clear, UIColor.clear, UIColor.clear,
        UIColor.clear, UIColor.clear, UIColor.clear, UIColor.clear,
        UIColor.clear, UIColor.clear, UIColor.clear, UIColor.clear
    ]
    // Array of the master code
    var masterCodeArray = [UIColor.clear, UIColor.clear, UIColor.clear, UIColor.clear]
    // Integer for what guess is currently active
    var guessCounter: Int = 0
    // Integer for the hint pegs
    var blackPeg: Int = 0
    var whitePeg: Int = 0
    
    // Function to randomly select 4 colors and return them to the program as an array
    mutating func getMasterCode() {
        for counter in 0...3 {
            let randomColor = colorArray.randomElement()!
            masterCodeArray[counter] = randomColor
        }
    } // End of getMasterCode()
    
    // Function to validate the answer provided by the user and return a string to the program
    mutating func validateAnswer() -> String {
        // Integer to figure out where in the guessArray to start
        let guessStart: Int = (guessCounter * 4) - 4
        // Arrays to see if the code position has been matched or not
        var codePositionArray = [true, true, true, true]
        var guessPositionArray = [true, true, true, true]
        // Array of guess values for later comparison
        let tempGuessArray = [guessCodeArray[guessStart], guessCodeArray[guessStart + 1],
                              guessCodeArray[guessStart + 2], guessCodeArray[guessStart + 3]]
        
        //Reset the Black and White Hint Pegs
        blackPeg = 0
        whitePeg = 0
        
        // Check to see if any color is set to Clear
        if guessCodeArray[guessStart] == UIColor.clear ||
            guessCodeArray[guessStart + 1] == UIColor.clear ||
            guessCodeArray[guessStart + 2] == UIColor.clear ||
            guessCodeArray[guessStart + 3] == UIColor.clear {
            return "You did not choose all colors. Please try again."
        // Check to see if all guess colors match the master code colors
        } else if tempGuessArray[0] == masterCodeArray [0] &&
                    tempGuessArray[1] == masterCodeArray [1] &&
                    tempGuessArray[2] == masterCodeArray [2] &&
                    tempGuessArray[3] == masterCodeArray [3] {
            return "Congratulations, you win!"
        // Set the hint pegs appropriately
        } else {
            for counter in 0...3 {
                // Check to see if the Guess code matches the Master code
                if tempGuessArray[counter] == masterCodeArray[counter] {
                    blackPeg += 1
                    codePositionArray[counter] = false
                    guessPositionArray[counter] = false
                }
            }
            for counter in 0...3 {
                if guessPositionArray[counter] == true {
                    if codePositionArray[0] == true && tempGuessArray[counter] == masterCodeArray[0] {
                        whitePeg += 1
                        codePositionArray[0] = false
                        guessPositionArray[counter] = false
                    } else if codePositionArray[1] == true && tempGuessArray[counter] == masterCodeArray[1] {
                        whitePeg += 1
                        codePositionArray[1] = false
                        guessPositionArray[counter] = false
                    } else if codePositionArray[2] == true && tempGuessArray[counter] == masterCodeArray[2] {
                        whitePeg += 1
                        codePositionArray[2] = false
                        guessPositionArray[counter] = false
                    } else if codePositionArray[3] == true && tempGuessArray[counter] == masterCodeArray[3] {
                        whitePeg += 1
                        codePositionArray[3] = false
                        guessPositionArray[counter] = false
                    }
                }
            }
            return "Sorry, that is incorrect."
        }
    }
}
