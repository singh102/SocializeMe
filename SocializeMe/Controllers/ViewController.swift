//
//  ViewController.swift
//  SocializeMe
//
//  Created by Karthik Singh on 2/22/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITextFieldDelegate {
    var userName: String = ""
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    let applicationState: ApplicationState = ApplicationState.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userNameField.text! = "akadiyala"
        passwordField.text! = "password"
        
        self.passwordField.delegate = self
        
    }
    
    @IBAction func editEnded(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
 
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let userNameText = userNameField.text {
            if let passwordText = passwordField.text {
                if userNameText.count > 0 && passwordText.count > 0 {
                    var actualPassword: String?
                    let usersRef = Database.database().reference().child("Users")
                    usersRef.observeSingleEvent(of: .value, with: {(snap : DataSnapshot) in
                        if snap.hasChild(userNameText) {
                            self.userName = userNameText
                        
                            let passwordRef = usersRef.child(userNameText)
                            
                            passwordRef.observeSingleEvent(of: .value, with: {(passSnap : DataSnapshot) in
                                if let value = passSnap.value {
                                  
                                    let passData = value as! [String: String]
                                    actualPassword = passData["password"]
                                    
                                    if let actualPass = actualPassword {
                                        if actualPass == passwordText {
                                            self.applicationState.name = self.userName
                                            self.performSegue(withIdentifier: "TabbedViewSegue", sender: self)
                                            
                                        } else {
                                          
                                            //print alert
                                            print("No Segue")
                                            self.present(AlertEngine.createIncorrectPasswordAlert(),
                                                         animated: true,
                                                         completion: nil)
                                        }
                                    }
                                    
                                }
                            }) { (err: Error) in
                                self.present(AlertEngine.createAlert("Unable to connect!"),
                                             animated: true,
                                             completion: nil)
                                
                                Swift.print("\(err.localizedDescription)")
                            }
                            
                            
                        } else {
                            
                            self.present(AlertEngine.createIncorrectPasswordAlert(),
                                         animated: true,
                                         completion: nil)
                        }
                        
                    }) { (err: Error) in
                        self.present(AlertEngine.createAlert("Unable to connect!"),
                                     animated: true,
                                     completion: nil)
                        
                        Swift.print("\(err.localizedDescription)")
                    }
                    
                }
            }
        }
    }
}
