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
        
        static let win: String = "Congratulations, you win! Would you like to play again?"
        static let lose: String = "You have failed to guess the proper code. Would you like to play again?"
        static let incomplete: String = "You did not choose all colors. Please try again."
        static let incorrect: String = "Sorry, that is incorrect."
    }
    
}
