//
//  ViewController.swift
//  Mastermind
//
//  Created by Michael & Diana Pascucci on 1/17/22.
//

import UIKit

class EntryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let uDefault = UserDefaults.standard
        
        // Check to make sure User Keys are available and have a value
        if uDefault.object(forKey: "Win") == nil {
            uDefault.set(0, forKey: "Win")
        }
        if uDefault.object(forKey: "Loss") == nil {
            uDefault.set(0, forKey: "Loss")
        }
        if uDefault.object(forKey: "Played") == nil {
            uDefault.set(0, forKey: "Played")
        }
        
    }

}

