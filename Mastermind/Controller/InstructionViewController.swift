//
//  InstructionViewController.swift
//  Mastermind
//
//  Created by Michael & Diana Pascucci on 1/21/22.
//

import UIKit

class InstructionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
