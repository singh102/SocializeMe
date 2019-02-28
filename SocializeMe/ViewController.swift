//
//  ViewController.swift
//  SocializeMe
//
//  Created by Karthik Singh on 2/22/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButtonPressed: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "ProfileViewSegue", sender: self)
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "FormViewSegue", sender: self)
    }
}

