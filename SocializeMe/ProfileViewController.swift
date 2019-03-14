//
//  ProfileViewController.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 2/28/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    var userInfo: UserInfoProfile = UserInfoProfile()
    
    @IBOutlet weak var userNameText: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var genderTextField: UILabel!
    @IBOutlet weak var occupationTextField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Here in profile view")
    
        userNameText.text! = self.userInfo.name
        email.text! = self.userInfo.email
        genderTextField.text! = self.userInfo.gender
        occupationTextField.text! = self.userInfo.occupation
        
        
        

        
    }
    
}
