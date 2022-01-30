//
//  Constants.swift
//  Mastermind
//
//  Created by Michael & Diana Pascucci on 1/29/22.
//

import Foundation

struct k {
    
    static let appTitle: String = "Mastermind"
    
    struct response {
        
        static let win: String =            "Congratulations, you win! Reset to try again"
        static let lose: String =           "You failed to crack the code. Reset to try again."
        static let incomplete: String =     "You did not choose all colors. Please try again."
        static let incorrect: String =      "Sorry, that is incorrect."
    }
    
}
