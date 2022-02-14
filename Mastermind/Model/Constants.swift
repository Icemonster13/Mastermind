//
//  Constants.swift
//  Mastermind
//
//  Created by Michael & Diana Pascucci on 1/29/22.
//

import Foundation

struct k {
    
    // Application Title
    static let appTitle: String = "Mastermind"
    
    // Responses used in the status label and message boxes
    struct response {
        
        static let win: String =                "Congratulations, you win! \n Reset to try again"
        static let lose: String =               "You failed to crack the code. \n Reset to try again."
        static let incomplete: String =         "You did not choose all colors. \n Please try again."
        static let incorrect: String =          "Sorry, that is incorrect."
        static let quitafterstart: String =     "Are you sure you want to do this? \n This will count against your statistics."
    }
    
    // User Default Keys for persistent data
    struct uDefaultKeys {
        
        static let win: String =                "Win"
        static let loss: String =               "Loss"
        static let played: String =             "Played"
    }
    
}
