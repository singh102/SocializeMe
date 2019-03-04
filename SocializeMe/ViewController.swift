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
    var variableToSend: String = ""
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
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        let incorrectUserNamePasswordController = ErrorEngine.createIncorrectPasswordAlert()
        if let userNameText = userNameField.text {
            if let passwordText = passwordField.text {
                if userNameText.count > 0 && passwordText.count > 0 {
                    var actualPassword: String?
                    let usersRef = Database.database().reference().child("Users")
                    usersRef.observeSingleEvent(of: .value, with: {(snap : DataSnapshot) in
                        if snap.hasChild(userNameText) {
                            self.userName = userNameText
                            self.retrieveProfileDataForUserName(self.userName)
                            print(self.variableToSend)
                            let passwordRef = usersRef.child(userNameText)
                            
                            passwordRef.observeSingleEvent(of: .value, with: {(passSnap : DataSnapshot) in
                                if let value = passSnap.value {
                                    let passData = value as! [String: String]
                                    actualPassword = passData["password"]
                                    
                                    if let actualPass = actualPassword {
                                        if actualPass == passwordText && self.userInfo.isValidUser() {
                                            
                                            self.performSegue(withIdentifier: "ProfileViewSegue", sender: self)
                                            
                                        } else {
                                            self.userInfo = UserInfoProfile()
                                            //print alert
                                            print("No Segue")
                                            self.present(incorrectUserNamePasswordController,
                                                         animated: true,
                                                         completion: nil)
                                        }
                                    }
                                    
                                }
                            }) { (err: Error) in
                                self.present(ErrorEngine.createErrorAlert("Unable to connect!"),
                                             animated: true,
                                             completion: nil)
                                
                                Swift.print("\(err.localizedDescription)")
                            }
                            
                            
                        } else {
                            
                            self.present(incorrectUserNamePasswordController,
                                         animated: true,
                                         completion: nil)
                        }
                        
                    }) { (err: Error) in
                        self.present(ErrorEngine.createErrorAlert("Unable to connect!"),
                                     animated: true,
                                     completion: nil)
                        
                        Swift.print("\(err.localizedDescription)")
                    }
                    
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ProfileViewSegue" {
            if let destination = segue.destination as? ProfileViewController {
                
                destination.userInfo = self.userInfo
                
            }
        }
    }
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        self.performSegue(withIdentifier: "FormViewSegue", sender: self)
        
    }
    
    func saveToUserInfo(_ name: String, _ gender: String, _ email: String, _ occupation: String) -> UserInfoProfile {
        
        let user = UserInfoProfile(name, gender, email, occupation)
        print("SAVE TO USER INFO METHOD CALL")
        
        return user
    }
    
    func retrieveProfileDataForUserName(_ userName: String) {
        if self.userName.count > 0 {
            let usersRef = Database.database().reference().child("profiles/\(userName)")
            usersRef.observeSingleEvent(of: .value, with: {(snap : DataSnapshot) in
                let userInfoDict = snap.value as! [String: String]
                let name: String = userInfoDict["name"] ?? ""
                let gender = userInfoDict["gender"] ?? ""
                let occupation = userInfoDict["occupation"] ?? ""
                let email = userInfoDict["email"] ?? ""
                
                
                
                self.userInfo = self.saveToUserInfo(name, gender, email, occupation)
                
                self.variableToSend = name
                
            }) { (err: Error) in
                print("\(err.localizedDescription)")
            }
        }
    }
}
