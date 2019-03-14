//
//  ProfileCreationViewController.swift
//  SocializeMe
//
//  Created by Karthik Singh on 3/13/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProfileCreationViewController: UIViewController {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtOccupation: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtEmail: UITextField!

    var dbRef: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = Database.database().reference();
    }
    
    @IBAction func doneEditing(_ sender: UITextField) {
        sender.resignFirstResponder();
    }
    
    @IBAction func save(_ sender: UIButton) {
        var newProfileDictionary: [String: String] = [:];
        
        if let fullName = txtFullName.text {
            newProfileDictionary["name"] = fullName;
        }
        
        if let email = txtEmail.text {
            newProfileDictionary["email"] = email;
        }
        
        if let gender = txtGender.text {
            newProfileDictionary["gender"] = gender;
        }
        
        if let occupation = txtOccupation.text {
            newProfileDictionary["occupation"] = occupation;
        }
        
        if let userName = txtUserName.text {
            self.dbRef.child("profiles")
                .child(userName)
                .setValue(newProfileDictionary);
            
            if let password = txtPassword.text {
                self.dbRef.child("Users")
                    .child(userName)
                    .setValue(["password": password]);
            }
        }
    }
}
