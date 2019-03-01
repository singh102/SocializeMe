//
//  ViewController.swift
//  SocializeMe
//
//  Created by Karthik Singh on 2/22/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    var userName: String = ""

    
    var userInfo: UserInfoProfile = UserInfoProfile()
    
    
    
    


    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButtonPressed: UIButton!
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        userNameField.text! = "akadiyala"
        passwordField.text! = "password"

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileViewSegue" {
        
            if let destination = segue.destination as? ProfileViewController {
                
                let usersRef = Database.database().reference().child("profiles/\(self.userName)")
                usersRef.observeSingleEvent(of: .value, with: {(snap : DataSnapshot) in
                    let userInfoDict = snap.value as! [String: String]
                    let name: String = userInfoDict["name"] ?? ""
                    let gender = userInfoDict["gender"] ?? ""
                    let occupation = userInfoDict["occupation"] ?? ""
                    let email = userInfoDict["email"] ?? ""
                    
                    self.userInfo.setName(name)
                    self.userInfo.setEmail(email)
                    self.userInfo.setGender(gender)
                    self.userInfo.setOccupation(occupation)
                    
                    //destination.userInfo? = self.userInfo
                    //destination.userInfo?.print()
                    print("View Controller \(name)")
                    destination.importantThing = name
                    print("here")
                   
                    
        
                    
                }) { (err: Error) in
                    print("\(err.localizedDescription)")
                }
                



            }
        }
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if let userNameText = userNameField.text {
            if let passwordText = passwordField.text {
                if userNameText.count > 0 && passwordText.count > 0 {
                    let usersRef = Database.database().reference().child("Users")
                    usersRef.observeSingleEvent(of: .value, with: {(snap : DataSnapshot) in
                        if snap.hasChild(userNameText) {
                            let passwordRef = usersRef.child(userNameText)
                            //print(usersRef.child("\(userNameText)/password").value(forKey: "password"))
                            
                            passwordRef.observeSingleEvent(of: .value, with: {(passSnap : DataSnapshot) in
                                if let value = passSnap.value {
                                    let passData = value as! [String: String]
                                    if let actualPassword = passData["password"] {
                                        if actualPassword ==  passwordText {
                                            self.userName = userNameText
                                            print(self.userName)
                                            print(passwordText)
                                            self.performSegue(withIdentifier: "ProfileViewSegue", sender: self)
                                        } else {
                                            print("No Segue for you")
                                        }
                                    }
                                }
                                
                            })
                        }
                        
                        
                        
                    }) { (err: Error) in
                        print("\(err.localizedDescription)")
                    }
                }
            }
        }
//        self.performSegue(withIdentifier: "ProfileViewSegue", sender: self)
        
        //let ref = Database.database().reference().child("profiles/akadiyala")
        
        
        
        
        
        
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "FormViewSegue", sender: self)
      
    }
}

