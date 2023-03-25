//
//  StartViewController.swift
//  AmiiboApp
//
//  Created by Ilya Zemskov on 25.03.2023.
//

import UIKit
import SpringAnimation

class StartViewController: UIViewController {
    
    @IBOutlet var logoButton: SpringButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        logoButton.animation = "pop"
        logoButton.curve = "easeIn"
        logoButton.duration = 3
        logoButton.force = 1
        logoButton.animate()
    }
    
    @IBAction func startButtonTapped() {
        performSegue(withIdentifier: "startTap", sender: nil)
    }
    
}
