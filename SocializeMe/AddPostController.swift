//
//  WallViewController.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 3/13/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation
import UIKit

class AddPostController: UIViewController {
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var postContent: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PostAddedSegue" {
            if let destination = segue.destination as? ProfileViewController {
                
                destination.postContent = self.postContent.text!
                
            }
        }
    }
    
    @IBAction func editEnded(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}
