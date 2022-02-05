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
        
        // Check to make sure UserDefault Keys are available and have a value
        if uDefault.object(forKey: k.uDefaultKeys.win) == nil {
            uDefault.set(0, forKey: k.uDefaultKeys.win)
        }
        if uDefault.object(forKey: k.uDefaultKeys.loss) == nil {
            uDefault.set(0, forKey: k.uDefaultKeys.loss)
        }
        if uDefault.object(forKey: k.uDefaultKeys.played) == nil {
            uDefault.set(0, forKey: k.uDefaultKeys.played)
        }
        
    }

}

