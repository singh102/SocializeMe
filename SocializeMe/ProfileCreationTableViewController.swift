//
//  ProfileCreationTableViewController.swift
//  SocializeMe
//
//  Created by Karthik Singh on 3/4/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ProfileCreationTableViewController: UITableViewController {

    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtOccupation: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference();
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 9
    }
    
    @IBAction func doneEditing(_ sender: UITextField) {
        sender.resignFirstResponder();
    }
    
    @IBAction func createProfile(_ sender: UIButton) {
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
            self.ref.child("profiles")
                .child(userName)
                .setValue(newProfileDictionary);
            
            if let password = txtPassword.text {
                self.ref.child("Users")
                    .child(userName)
                    .setValue(["password": password]);
            }
        }
    }
}
